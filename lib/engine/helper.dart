import 'dart:ui';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/ui/screen/premiumScreen.dart';

import 'colors.dart';
import 'sharedPreferenceManager.dart';
const String testDevices = 'your_device_id';
class Helper {
	static RewardedVideoAd videoAd = RewardedVideoAd.instance;


	static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
		keywords: <String>['flutterio', 'beautiful apps'],
		contentUrl: 'https://flutter.io',
		childDirected: false,
		testDevices: testDevices != null ? <String>['testDevices'] : null,
	);

	static playAd() {

	}

	static void showTutorial(BuildContext context, {String title = "", String message = "", bool dismissable = true}) {
		showDialog(
			context: context,
			barrierDismissible: dismissable,
			builder: (BuildContext context) {
				return AlertDialog(
					backgroundColor: AlertDialogTheme.colorBackground,
					title: Text(
						title,
						style: TextStyle(color: AlertDialogTheme.textColor),
					),
					content: Text(
						message,
						style: TextStyle(color: ColorConstants.text_color_2),
					),
					actions: <Widget>[
						FlatButton(
							child: Text("Got it!", style: TextStyle(color: AlertDialogTheme.textColor)),
							onPressed: () {
								Navigator.of(context).pop();
							},
						)
					],
				);
			});
	}

	static void popUP(BuildContext context, {String title = "", String message = "", bool dismissable = true}) {
		showDialog(
			context: context,
			barrierDismissible: dismissable,
			builder: (BuildContext context) {
				return AlertDialog(
					backgroundColor: AlertDialogTheme.colorBackground,
					title: Text(
						title,
						style: TextStyle(color: AlertDialogTheme.textColor),
					),
					content: Text(
						message,
						style: TextStyle(color: ColorConstants.text_color_2),
					),
					actions: <Widget>[
						FlatButton(
							child: Text("Watch AD", style: TextStyle(color: NegativeButtonStyle.textColor)),
							onPressed: () {
								FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
								videoAd.load(adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo).then((value){
									videoAd.show();
								});
								videoAd.listener =
									(RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
									if (event == RewardedVideoAdEvent.rewarded) {
										SharedPreferenceManager.saveOnSharePregInt('skip_mode', 1);
										Navigator.pop(context, 1);
									}
								};

							},
						),
						FlatButton(
							child: Text("Go Premium!", style: TextStyle(color: AlertDialogTheme.textColor)),
							onPressed: () {
								Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumScreen()));
							},
						)
					],
				);
			});
	}

	static void showErrorToast(String error) {
		print(error);
		Fluttertoast.showToast(
			msg: error,
			toastLength: Toast.LENGTH_LONG,
		);
	}
}
