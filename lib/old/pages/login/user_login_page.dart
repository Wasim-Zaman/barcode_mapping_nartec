import 'package:barcode_mapping/core/constants/app_icons.dart';
import 'package:barcode_mapping/core/constants/app_preferences.dart';
import 'package:barcode_mapping/global/common/colors/app_colors.dart';
import 'package:barcode_mapping/global/common/utils/app_dialogs.dart';
import 'package:barcode_mapping/global/common/utils/app_navigator.dart';
import 'package:barcode_mapping/global/common/utils/app_snakbars.dart';
import 'package:barcode_mapping/global/widgets/buttons/primary_button.dart';
import 'package:barcode_mapping/global/widgets/drop_down/drop_down_widget.dart';
import 'package:barcode_mapping/global/widgets/text_field/text_field_widget.dart';
import 'package:barcode_mapping/old/domain/services/apis/login/login_services.dart';
import 'package:barcode_mapping/old/pages/login/activities_and_password_page.dart';
import 'package:barcode_mapping/old/providers/login/login_provider.dart';
import 'package:barcode_mapping/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});
  static const String pageName = '/login';

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //controllers
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();

    //focus nodes
    emailNode.dispose();
    passwordNode.dispose();

    super.dispose();
  }

  login() {
    if (formKey.currentState?.validate() ?? false) {
      AppDialogs.loadingDialog(context);
      LoginServices.newLogin(email: emailController.text).then((response) {
        AppDialogs.closeDialog();
        final activities = response;

        // add email and activities to login provider
        Provider.of<LoginProvider>(context, listen: false)
            .setEmail(emailController.text);
        Provider.of<LoginProvider>(context, listen: false)
            .setActivities(activities);

        AppPreferences.setCurrentUser("Admin").then((_) {});

        AppNavigator.goToPage(
          context: context,
          screen: ActivitiesAndPasswordPage(
            email: emailController.text.trim(),
            activities: activities,
          ),
        );
      }).catchError((error) {
        AppDialogs.closeDialog();
        AppSnackbars.danger(context, error.toString());
      });
    }
  }

  brandOwnerLogin() async {
    AppDialogs.loadingDialog(context);
    LoginServices.brandOwnerLogin(
      emailController.text.trim(),
      passwordController.text.trim(),
    ).then((value) {
      AppPreferences.setToken(value.token.toString()).then((_) {});
      AppPreferences.setUserId(value.data!.userID.toString()).then((_) {});
      AppPreferences.setNormalUserId(emailController.text.trim().toString())
          .then((_) {});
      AppPreferences.setCurrentUser("Brand Owner").then((_) {});

      AppDialogs.closeDialog();
      AppSnackbars.success(context, "Login Successful", 2);
      AppNavigator.replaceTo(context: context, screen: const HomeScreen());
    }).onError((error, stackTrace) {
      AppDialogs.closeDialog();
      AppSnackbars.danger(context, error.toString());
    });
  }

  supplierOwnerLogin() async {
    AppDialogs.loadingDialog(context);
    LoginServices.supplierLogin(
      emailController.text.trim(),
      passwordController.text.trim(),
    ).then((value) {
      AppPreferences.setToken(value.token.toString()).then((_) {});
      AppPreferences.setUserId(value.data!.userId.toString()).then((_) {});
      AppPreferences.setNormalUserId(emailController.text.trim().toString())
          .then((_) {});
      AppPreferences.setCurrentUser("Supplier").then((_) {});
      AppPreferences.setVendorId(value.data!.vendorId.toString()).then((_) {});

      AppDialogs.closeDialog();
      AppSnackbars.success(context, "Login Successful", 2);
      AppNavigator.replaceTo(context: context, screen: const HomeScreen());
    }).onError((error, stackTrace) {
      AppDialogs.closeDialog();
      AppSnackbars.danger(context, error.toString());
    });
  }

  String currentUser = "";

  String dropdownValue = "Admin User";
  List<String> dropdownList = [
    "Admin User",
    "Normal User",
  ];

  String stakeHolderValue = "Brand Owner";
  List<String> stakeHolderList = [
    "Brand Owner",
    "Manufacturer",
    "Supplier",
    "Distributor",
    "Retailer",
    "Local Authority",
  ];

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'User Type',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropDownWidget(
                          items: dropdownList,
                          value: dropdownValue,
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value!;
                              if (dropdownValue == "Admin User") {
                                currentUser = "Admin";
                              }
                              emailController.clear();
                              passwordController.clear();
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'User Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFieldWidget(
                          hintText: "Login ID",
                          controller: emailController,
                          focusNode: emailNode,
                          keyboardType: TextInputType.emailAddress,
                          leadingIcon: Image.asset(AppIcons.usernameIcon),
                          onFieldSubmitted: (p0) {
                            if (dropdownValue == "Admin User") {
                              // hide the keyboard
                              emailNode.unfocus();
                            } else {
                              // scope to password node
                              FocusScope.of(context).requestFocus(passwordNode);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your login ID';
                            }
                            // if (EmailValidator.validate(value)) {
                            //   return null;
                            // } else {
                            //   return 'Please enter a valid email';
                            // }
                            return null;
                          },
                        ).box.width(context.width * 0.9).make(),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: dropdownValue == "Admin User" ? false : true,
                          child: TextFieldWidget(
                            hintText: "Password",
                            focusNode: passwordNode,
                            onFieldSubmitted: (p0) {
                              // hide keyboard
                              passwordNode.unfocus();
                            },
                            controller: passwordController,
                            leadingIcon: Image.asset(
                              AppIcons.passwordIcon,
                              width: 42,
                              height: 42,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureText,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: dropdownValue == "Admin User" ? false : true,
                          child: const Text(
                            'Stakeholder Type',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: dropdownValue == "Admin User" ? false : true,
                          child: DropDownWidget(
                            items: stakeHolderList,
                            value: stakeHolderValue,
                            onChanged: (value) {
                              setState(() {
                                stakeHolderValue = value!;
                                currentUser = stakeHolderValue;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButtonWidget(
                          // rgba(66, 0, 255, 1)
                          backgroungColor: AppColors.green,
                          onPressed: () {
                            if (dropdownValue.toString() == "Normal User") {
                              if (stakeHolderValue == "Brand Owner") {
                                brandOwnerLogin();
                                return;
                              }
                              if (stakeHolderValue == "Supplier") {
                                supplierOwnerLogin();
                                return;
                              }
                            }

                            if (dropdownValue.toString() == "Admin User") {
                              login();
                              return;
                            }
                          },
                          text: "Login Now",
                        ).box.width(context.width * 0.85).makeCentered(),
                        const SizedBox(height: 20),
                        // remember me and neeed help
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Need Help?',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
