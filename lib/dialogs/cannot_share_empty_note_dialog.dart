import 'package:flutter/material.dart';
import 'package:fractoliotesting/dialogs/generic_dialog.dart';

Future<void> showCannotEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Sharing',
      content: "You cannot share an empty note",
      optionBuilder: () => {
            'OK': null,
          });
}
