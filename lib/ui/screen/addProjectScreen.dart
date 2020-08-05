import 'dart:ui';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/model/Project.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/imagePicker.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/utility.dart';
import 'package:plotgenerator/generated/i18n.dart';

import '../../engine/colors.dart';
import '../../engine/common.dart';
import '../../engine/sharedPreferenceManager.dart';
import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

const String testDevices = 'your_device_id';
class AddProjectScreen extends StatefulWidget {
	AddProjectScreen({Key key, this.title}) : super(key: key);

	final String title;

	@override
	AddProjectScreenState createState() => AddProjectScreenState();
}

class AddProjectScreenState extends State<AddProjectScreen> {
	final nameController = TextEditingController();
	final summaryController = TextEditingController();

	String genre = "";
	String summary = "";
	String imgString = "";
	int skipMode = 0;

	RewardedVideoAd videoAd = RewardedVideoAd.instance;
	MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
		keywords: <String>['flutterio', 'beautiful apps'],
		contentUrl: 'https://flutter.io',
		childDirected: false,
		testDevices: testDevices != null ? <String>['testDevices'] : null,
	);

	@override
	void initState() {
		super.initState();
		if ( !Common.isPAU) {
			FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
		}
		Future.delayed(Duration.zero, this.checkTutorial);

		if (Common.isPAU) {
			SharedPreferenceManager.saveOnSharePregInt('skip_mode', 1);
			skipMode = 1;
		}

	}

	@override
	void dispose() {
		nameController.dispose();
		summaryController.dispose();
		super.dispose();
	}

	checkTutorial() {
		TutorialManager.check(context);
	}

	onPhoto(BuildContext context) {
		CustomImagePicker.show(context, (imageFile) {
			setState(() {
				if (imageFile == null)
					this.imgString = '';
				else
					this.imgString = Utility.base64String(imageFile.readAsBytesSync());
			});
		});
	}

	onSave(BuildContext context) {
		if (Common.isPAU || Common.projectCount < 2  || skipMode == 1 ) {
			if (nameController.text == "") {
				Helper.showErrorToast(S.of(context).projects_empty);
				return;
			}

			Project project = Project(name: nameController.text,
				genre: genre,
				plot: summaryController.text,
				image: imgString);
			DatabaseHelper().createProject(project).then((value) {
				Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
			});
		} else {
			popUP(context, title: S.of(context).premiumOnlyPopTitle, message: S.of(context).premiumOnlyPopBody);
		}
	}

	gotoProfileScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
	}

	gotoPremiumScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumScreen()));
	}

	gotoDiscoverScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
	}

	gotoChallengeScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeScreen()));
	}

	gotoPromptsScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => PromptsScreen()));
	}

	gotoMainScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			drawer: Drawer(
				child: ListView(
					padding: EdgeInsets.zero,
					children: <Widget>[
						Container(
							height: 90.0,
							child: DrawerHeader(
								child: Text(
									"",
								),
								decoration: BoxDecoration(color: Common.containerBackColor)),
						),
						ListTile(
							leading: SvgPicture.asset(ImageConstants.SideMenuWorkshop, color: Common.containerBackColor),
							title: Text(S.of(context).story_tab),
							onTap: () => {gotoMainScreen(context)},
						),
						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: Image.asset(ImageConstants.SideMenuChallenge, color: Common.containerBackColor),
							),
							title: Text(S.of(context).writing_challenge_tab),
							onTap: () => {gotoChallengeScreen(context)},
						),

						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: SvgPicture.asset(ImageConstants.SideMenuPrompts, color: Common.containerBackColor),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).trigger_tab),
							onTap: () => {gotoPromptsScreen(context)},
						),
						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: Image.asset(ImageConstants.SideMenuPremium, color: Common.containerBackColor),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).premium_tab),
							onTap: () => {gotoPremiumScreen(context)},
						),
						ListTile(
							leading: SvgPicture.asset(ImageConstants.SideMenuProfile, color: Common.containerBackColor),
							title: Text(S.of(context).my_profile),
							onTap: () => {gotoProfileScreen(context)},
						),
					],
				),
			),
			appBar: AppBar(
				title: Text(S.of(context).projects_tab),
			),
			body: SingleChildScrollView(
				child: ConstrainedBox(
					constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							GestureDetector(
								onTap: () => onPhoto(context),
								child: Container(
									padding: EdgeInsets.only(top: 16, bottom: 16),
									height: 80,
									child: this.imgString == ''
										? Icon(
										Icons.camera_alt,
										size: 80)
										: Utility.imageFromBase64String(imgString)),
							),
							SizedBox(
								height: 20,
							),
							projectNameContainer(context),
							SizedBox(
								height: 20,
							),
							genreContainer(context),
							SizedBox(
								height: 20,
							),
							summaryContainer(context),
						],
					),
				),
			),
			floatingActionButton: Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: [

					FloatingActionButton(
						heroTag: 1,
						child: Icon(Icons.save),
						onPressed: () => onSave(context),
					),
				],
			));
	}

	projectNameContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						S.of(context).project_name,
						style: TextStyle(fontSize: 20),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						style: TextStyle(  fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: nameController,
						maxLines: 1,
					),
				],
			),
		));
	}

	genreContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						S.of(context).project_genre,
						style: TextStyle(fontSize: 20),
					),
					SizedBox(
						height: 10,
					),
					genderDropDown(context),
				],
			),
		));
	}

	genderDropDown(BuildContext context) {
		List<String> genreList = StringConstants.genresList(context);
		if (genre == "") {
			setState(() {
				genre = genreList[0];
			});
		}
		return (Container(
			child: DropdownButton<String>(
				value: genre,
				icon: Icon(Icons.arrow_drop_down),
				iconSize: 24,
				style: TextStyle(fontSize: 18, color: Colors.black),
				isExpanded: true,
				onChanged: (String data) {
					setState(() {
						genre = data;
					});
				},
				items: genreList.map((e) {
					return DropdownMenuItem(
						value: e,
						child: Text(e),
					);
				}).toList()),
		));
	}

	summaryContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						S.of(context).project_summary,
						style: TextStyle(fontSize: 20),
					),
					SizedBox(
						height: 10,
					),
					Container(
						height: 200,
						child: TextField(
							controller: summaryController,
							keyboardType: TextInputType.multiline,
							maxLines: null,
							expands: true,
						))
				],
			),
		));
	}



	void popUP(BuildContext context, {String title = "", String message = "", bool dismissable = true}) {
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
								videoAd.load(adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo).then((result){
									if (result){
										videoAd.show();
									}
								});

								videoAd.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
									if (event == RewardedVideoAdEvent.rewarded) {
										SharedPreferenceManager.saveOnSharePregInt('skip_mode', 0);
										Navigator.pop(context, 1);
										setState(() {
										  skipMode = 1;
										});
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
}
