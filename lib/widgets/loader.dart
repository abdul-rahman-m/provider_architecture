import 'package:flutter/material.dart';
import 'package:provider_stub/providers/primary_provider.dart';
import 'package:provider_stub/res/app_colors.dart';

appLoader() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      );
    },
  );
}


appInternet() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: FractionallySizedBox(
          widthFactor: 0.34,
          heightFactor: 0.14,
          child: Card(
              color: Colors.white,
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text("No Internet Connection"),
              )),
        ),
      );
    },
  );
}