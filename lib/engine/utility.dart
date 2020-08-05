import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import '../main.dart';
import 'colors.dart';
import 'common.dart';

class Utility {
	static Image imageFromBase64String(String base64String) {
		return Image.memory(
			base64Decode(base64String),
			fit: BoxFit.cover,
		);
	}

	static Uint8List dataFromBase64String(String base64String) {
		return base64Decode(base64String);
	}

	static String base64String(Uint8List data) {
		return base64Encode(data);
	}

	static void updateUI(int theme){
		switch (theme) {
			case 0:
				Common.containerBackColor =ColorConstants.colorPrimaryDark;
				Common.storyDetailTextColor = ColorConstants.headline;
				Common.premiumTextColor = ColorConstants.colorPrimaryDark;
				runApp(MyApp(theme: 0));
				break;
			case 1:
				Common.containerBackColor = MetalTheme.backgroundDarker;
				Common.storyDetailTextColor = ColorConstants.headline;
				Common.premiumTextColor = MetalTheme.textColorSecondary;
				runApp(MyApp(theme: 1));
				break;
			case 2:
				Common.containerBackColor = DarkTheme.backgroundDarker;
				Common.storyDetailTextColor = ColorConstants.headline;
				Common.premiumTextColor = DarkTheme.textColorSecondary;
				runApp(MyApp(theme: 2));
				break;
			case 3:
				Common.containerBackColor = OpaqueTheme.backgroundDarker;
				Common.storyDetailTextColor = ColorConstants.headline;
				Common.premiumTextColor = OpaqueTheme.textColorSecondary;
				runApp(MyApp(theme: 3));
				break;
			case 4:
				Common.containerBackColor = AutumnTheme.backgroundDarker;
				Common.storyDetailTextColor = ColorConstants.headline;
				Common.premiumTextColor = Colors.grey;
				runApp(MyApp(theme: 4));
				break;
			case 5:
				Common.containerBackColor = WhiteTheme.backgroundDarker;
				Common.storyDetailTextColor = ColorConstants.headline;
				Common.premiumTextColor = WhiteTheme.textColorSecondary;
				runApp(MyApp(theme: 5));
				break;

		}
	}
}