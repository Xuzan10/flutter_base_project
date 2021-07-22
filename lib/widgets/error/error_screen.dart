import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? retryCallback;
  final bool hideRetry;

  const ErrorScreen(
      {Key? key,
      this.errorMessage = "Something went wrong.",
      this.retryCallback,
      this.hideRetry = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, height: 1.4.sp),
            ),
            !hideRetry
                ? IconButton(
                    icon: Icon(Icons.refresh), onPressed: retryCallback)
                : Container()
          ],
        ),
      ),
    );
  }
}
