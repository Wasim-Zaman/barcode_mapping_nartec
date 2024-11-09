import 'package:barcode_mapping/global/common/colors/app_colors.dart';
import 'package:barcode_mapping/global/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppDialogs {
  static BuildContext? dialogueContext;
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogueContext = ctx;
        return const LoadingWidget();
      },
    );
  }

  static void closeDialog() {
    Navigator.pop(dialogueContext!);
  }

  static Future<dynamic> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: SpinKitCircle(
            duration: Duration(milliseconds: 1200),
            color: AppColors.primary,
            size: 50.0,
          ),
        );
      },
    );
  }
}
