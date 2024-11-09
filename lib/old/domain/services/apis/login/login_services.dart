// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:barcode_mapping/core/constants/app_preferences.dart';
import 'package:barcode_mapping/core/constants/app_urls.dart';
import 'package:barcode_mapping/models/LoginUser/BrandOwnerLoginModel.dart';
import 'package:barcode_mapping/models/LoginUser/SupplierLoginModel.dart';
import 'package:barcode_mapping/models/Member/member_data_model.dart';
import 'package:barcode_mapping/models/activities/email_activities_model.dart';
import 'package:barcode_mapping/models/activities/new_activities_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginServices {
  static Future<void> confirmation(
    BuildContext context,
    String email,
    String activity,
    String activityId,
    String password,
    String generatedOTP,
    String memberOtp,
  ) async {
    MemberDataModel member = MemberDataModel();
    final baseUrl = '${AppUrls.domain}/api/otp/confirmation';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'activityID': activityId,
          'password': password,
          'generated_otp': generatedOTP,
          'member_otp': memberOtp
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': 'gs1ksa.org',
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // Setting preferences
        final data = json.decode(response.body);

        member = MemberDataModel.fromJson(data['memberData']);

        AppPreferences.setUserId(member.user!.id.toString()).then((_) {});
        AppPreferences.setGcp(member.user!.gcpGLNID.toString()).then((_) {});
        AppPreferences.setMemberCategoryDescription(
                member.memberCategory!.memberCategoryDescription.toString())
            .then((_) {});
      } else {
        throw Exception('Invalid OTP, Please try again');
      }
    }).onError(
      (error, stackTrace) => throw Exception(
        'Invalid OTP, Please try again',
      ),
    );
  }

  static Future<Map<String, dynamic>> sendOTP(String email, String activity) {
    final baseUrl = '${AppUrls.domain}/api/send/otp';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          'email': email,
          'activity': activity,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': 'gs1ksa.org',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IklyZmFuIiwiaWF0IjoxNTE2MjM5MDIyfQ.vx1SEIP27zyDm9NoNbJRrKo-r6kRaVHNagsMVTToU6A',
      },
    ).then((response) {
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        return responseBody;
      } else {
        throw Exception('Error happended while sending OTP');
      }
    });
  }

  static Future<Map<String, dynamic>> loginWithPassword(
    String email,
    String activity,
    String password,
    String activityId,
  ) {
    final baseUrl = '${AppUrls.domain}/api/member/login';
    final uri = Uri.parse(baseUrl);

    print(jsonEncode({
      'email': email,
      'activity': activity,
      'activityID': activityId,
      'password': password,
    }));

    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'activityID': activityId,
          'password': password,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': 'gs1ksa.org',
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // handle successful response
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        return responseBody;
      } else if (response.statusCode == 422) {
        throw Exception('Please Wait For Admin Approval');
      } else {
        throw Exception('Error happended while logging in');
      }
    });
  }

  static Future<Map<String, dynamic>> newLoginWithPassword(
    String email,
    String activity,
    String password,
    String activityId,
  ) {
    final baseUrl = '${AppUrls.domain}/api//users/memberLogin';
    final uri = Uri.parse(baseUrl);

    print(jsonEncode({
      'email': email,
      'activity': activity,
      'activityID': activityId,
      'password': password,
    }));

    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'activityID': activityId,
          'password': password,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': 'gs1ksa.org',
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // handle successful response
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        return responseBody;
      } else if (response.statusCode == 422) {
        throw Exception('Please Wait For Admin Approval');
      } else {
        throw Exception('Error happended while logging in');
      }
    });
  }

  static Future<List<EmailActivitiesModel>> login({String? email}) async {
    final baseUrl = '${AppUrls.domain}/api/email/verification';

    final uri = Uri.parse(baseUrl);
    try {
      print("uri: $uri");
      final response =
          await http.post(uri, body: json.encode({'email': email}), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': AppUrls.host,
      });

      print('response: ${response.statusCode}');

      if (response.statusCode == 200) {
        // handle successful response
        final responseBody = json.decode(response.body);
        final data = responseBody['activities'] as List;
        final List<EmailActivitiesModel> emailActivities = [];
        for (final item in data) {
          emailActivities.add(EmailActivitiesModel.fromJson(item));
        }
        return emailActivities;
      } else if (response.statusCode == 404) {
        // print('responseBody: ${json.decode(response.body)}');

        // return {
        //   "message": "Email doesn't exist",
        // };
        throw Exception('Email doesn\'t exist');
      } else {
        // print('responseBody: ${json.decode(response.body)}');

        // handle error response
        throw Exception('Error happended while loading data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<NewActivitiesModel>> newLogin({String? email}) async {
    final baseUrl = '${AppUrls.domain}/api/users/getCrInfoByEmail?email=$email';

    final uri = Uri.parse(baseUrl);
    try {
      print("uri: $uri");
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': AppUrls.host,
      });

      print('response: ${response.body}');

      if (response.statusCode == 200) {
        // handle successful response
        final responseBody = json.decode(response.body);
        final data = responseBody as List;
        final List<NewActivitiesModel> emailActivities = [];
        for (final item in data) {
          emailActivities.add(NewActivitiesModel.fromJson(item));
        }
        return emailActivities;
      } else if (response.statusCode == 404) {
        // print('responseBody: ${json.decode(response.body)}');

        // return {
        //   "message": "Email doesn't exist",
        // };
        throw Exception('Email doesn\'t exist');
      } else {
        // print('responseBody: ${json.decode(response.body)}');

        // handle error response
        throw Exception('Error happended while loading data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<BrandOwnerLoginModel> brandOwnerLogin(
    String email,
    String pass,
  ) async {
    final baseUrl = '${AppUrls.baseUrlWithPort}loginUser';
    final uri = Uri.parse(baseUrl);

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Host': AppUrls.host,
    };

    final body = jsonEncode(
      {'Email': email, 'UserPassword': pass},
    );

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
        final responseBody = json.decode(response.body);
        return BrandOwnerLoginModel.fromJson(responseBody);
      } else {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        String msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<SupplierLoginModel> supplierLogin(
    String email,
    String pass,
  ) async {
    final baseUrl = '${AppUrls.baseUrlWithPort}loginInternalUser';
    final uri = Uri.parse(baseUrl);

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Host': AppUrls.host,
    };

    final body = jsonEncode(
      {'user_email': email, 'user_password': pass},
    );

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
        final responseBody = json.decode(response.body);
        return SupplierLoginModel.fromJson(responseBody);
      } else {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        String msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
