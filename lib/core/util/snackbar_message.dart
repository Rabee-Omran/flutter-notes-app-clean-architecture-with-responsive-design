import 'package:another_flushbar/flushbar.dart';
import '../responsive.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SnackBarMessage {
  void showSuccessSnackBar({message, context}) {
    if (Responsive.isMobile(context))
      Flushbar(
        message: message,
        icon: Icon(
          Icons.done,
          size: 28.0,
          color: Colors.green[300],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.green[300],
      )..show(context);
    else {
      _buildSuccessDialog(context, message);
    }
  }

  void showErrorSnackBar({message, context}) {
    if (Responsive.isMobile(context))
      Flushbar(
        message: message,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.redAccent,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.redAccent,
      )..show(context);
    else {
      _buildErrorDialog(context, message);
    }
  }

  AwesomeDialog _buildSuccessDialog(context, message) {
    return AwesomeDialog(
      width: MediaQuery.of(context).size.width / 2,
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: message,
      btnOk: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: Text(
            "Ok",
          ),
        ),
      ),
    )..show();
  }

  AwesomeDialog _buildErrorDialog(context, message) {
    return AwesomeDialog(
      width: MediaQuery.of(context).size.width / 2,
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: message,
      btnOk: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: Text(
            "Ok",
          ),
        ),
      ),
    )..show();
  }
}
