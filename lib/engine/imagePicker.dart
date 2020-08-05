import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plotgenerator/generated/i18n.dart';


import 'colors.dart';

typedef ImagePickerListener = Function(File imageFile);
class CustomImagePicker {
	static void _callListener(ImagePickerListener listener, File imageFile) {
		if (listener != null) { listener(imageFile); }
	}

	static void show(BuildContext context, ImagePickerListener listener) {
		showDialog(
			context: context,
			barrierDismissible: true,
			builder: (BuildContext context) {
				return AlertDialog(
					backgroundColor: AlertDialogTheme.colorBackground,
					title: Text(
						S.of(context).please_select_the_one_option,
						style: TextStyle(color: AlertDialogTheme.textColor),
					),
					actions: <Widget>[
						FlatButton(
							child: Text(S.of(context).select_from_photo_gallery, style: TextStyle(color: AlertDialogTheme.textColor)),
							onPressed: () async {
								var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
								_callListener(listener, imageFile);
								Navigator.of(context).pop();
							},
						),
						FlatButton(
							child: Text(S.of(context).remove_photo, style: TextStyle(color: AlertDialogTheme.textColor)),
							onPressed: () {
								_callListener(listener, null);
								Navigator.of(context).pop();
							},
						)
					],
				);
			});
	}
}
