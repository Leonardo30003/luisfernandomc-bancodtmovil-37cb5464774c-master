import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class AwaitsDialogs {
  BuildContext context;

  AwaitsDialogs(this.context);

  late ProgressDialog progressDialog;

  show(String title, String message) {
    try {
      progressDialog = ProgressDialog(
        context,
        blur: 0,
        dialogTransitionType: DialogTransitionType.Shrink,
        title: const AutoSizeText('title'),
        message: const AutoSizeText('message'),
        defaultLoadingWidget:
            CircularProgressIndicator(color: Theme.of(context).primaryColor),
        onDismiss: () {
          log('Dismiss');
        },
      );
      progressDialog.setLoadingWidget(CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
      ));
      progressDialog.setTitle(Text(title));
      progressDialog.setMessage(Text('        $message'));
      progressDialog.show();
    } catch (onError) {
      log('ERROR SHOW ::> $onError');
    }
  }

  hide() {
    try {
      if (progressDialog.isShowed) {
        progressDialog.dismiss();
      }
    } catch (onError) {
      log('ERROR DISMISS:: $onError');
    }
  }
}
