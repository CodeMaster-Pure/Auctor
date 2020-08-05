import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/model/Project.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/imagePicker.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/sharedPreferenceManager.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/model/OffStory.dart';
import 'package:plotgenerator/model/Outline.dart';
import 'package:plotgenerator/ui/screen/characterListScreen.dart';
import 'package:plotgenerator/ui/screen/outlineListScreen.dart';

import '../../engine/colors.dart';
import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class WriteStoryScreen extends StatefulWidget {
	WriteStoryScreen({Key key}) : super(key: key);

	@override
	WriteStoryScreenState createState() => WriteStoryScreenState();
}

class WriteStoryScreenState extends State<WriteStoryScreen> {

	WriteStoryScreenState();
	final storyController = TextEditingController();


	@override
	void initState() {
		super.initState();
		SharedPreferenceManager.getSharePref('offlineStory_create_mode', 0).then((value){
			if (value == 1) {
				DatabaseHelper.sharedInstance.getOfflineStory(1).then((value){
					if (value != null){
						setState(() {
						  storyController.text = value.story;
						  print(value.story);
						});
					}
				});
			}

		});
	}

	@override
	void dispose() {
		storyController.dispose();
		super.dispose();
	}

	onSave(BuildContext context) {
		if (storyController.text == "") { Helper.showErrorToast(S.of(context).write_story_empty); return; }

		SharedPreferenceManager.getSharePref('offlineStory_create_mode', 0).then((value){
			if (value == 0) {
				OffStory offStory = new OffStory(id: 1 ,project_id: Common.currentProject.id.toString(), story: storyController.text, project_name: Common.currentProject.name );
				DatabaseHelper().createOffLineStory(offStory).then((result){
					if (result == 1) {
						Fluttertoast.showToast(msg: 'Saved your story!');
						SharedPreferenceManager.saveOnSharePregInt('offlineStory_create_mode', 1);
					} else
						Fluttertoast.showToast(msg: 'Failed operation!');

				});
			} else {
				OffStory offStory = new OffStory(id: 1, project_id: Common.currentProject.id.toString(), story: storyController.text, project_name: Common.currentProject.name );
				DatabaseHelper().updateOfflineStory(offStory).then((result){
					if (result == 1) {
						Fluttertoast.showToast(msg: 'Saved your story!');
						SharedPreferenceManager.saveOnSharePregInt('offlineStory_create_mode', 1);
					} else
						Fluttertoast.showToast(msg: 'Failed operation!');

				});
			}



			Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterListScreen()));
		});
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
									style: TextStyle(color: Colors.white, fontSize: 25, height: 20),
								),
								decoration: BoxDecoration(color: MetalTheme.backgroundDarker)),
						),
						ListTile(
							leading: SvgPicture.asset(ImageConstants.SideMenuWorkshop, color: ColorConstants.colorPrimaryDark),
							title: Text(S.of(context).story_tab),
							onTap: () => {gotoMainScreen(context)},
						),
						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: Image.asset(ImageConstants.SideMenuChallenge, color: ColorConstants.colorPrimaryDark),
							),
							title: Text(S.of(context).writing_challenge_tab),
							onTap: () => {gotoChallengeScreen(context)},
						),

						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: SvgPicture.asset(ImageConstants.SideMenuPrompts, color: ColorConstants.colorPrimaryDark),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).trigger_tab),
							onTap: () => {gotoPromptsScreen(context)},
						),
						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: Image.asset(ImageConstants.SideMenuPremium, color: ColorConstants.colorPrimaryDark),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).premium_tab),
							onTap: () => {gotoPremiumScreen(context)},
						),
						ListTile(
							leading: SvgPicture.asset(ImageConstants.SideMenuProfile, color: ColorConstants.colorPrimaryDark),
							title: Text(S.of(context).my_profile),
							onTap: () => {gotoProfileScreen(context)},
						),
					],
				),
			),
			appBar: AppBar(
				title: Text(Common.currentProject.name),
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.share),
						onPressed: (){
							if (!Common.isPAU)
								Fluttertoast.showToast(msg: S.of(context).premiumOnly);
							else {
								share(storyController.text);
							}
						},
					),
					IconButton(
						icon: Icon(Icons.save),
						onPressed: (){
							onSave(context);
						},
					)
				],
			),
			body: storyContainer()
		);
	}

	Widget storyContainer() {
		return Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					SizedBox(
						height: 20,
					),
//					Row(
//						mainAxisAlignment: MainAxisAlignment.center,
//						children: <Widget>[
//							IconButton(
//								icon: Icon(Icons.format_bold),
//								onPressed: (){
//									setState(() {
//										storyController.text = '\btest test\b';
//									});
//
//								},
//							),
//							IconButton(
//								icon: Icon(Icons.format_italic),
//								onPressed: (){
//
//								},
//							),
//							IconButton(
//								icon: Icon(Icons.format_align_left),
//								onPressed: (){
//
//								},
//							),
//							IconButton(
//								icon: Icon(Icons.format_align_center),
//								onPressed: (){
//
//								},
//							),
//							IconButton(
//								icon: Icon(Icons.format_align_right),
//								onPressed: (){
//
//								},
//							)
//						],
//					),
					SizedBox(
						height: 10,
					),
					TextField(
						style: TextStyle(color: Colors.black, fontSize: 18),
						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: storyController,
						maxLines: 10,
					),
				],
			),
		);
	}

//	getSeletedText() {
//		String sub = storyController.text.substring(storyController.selection.baseOffset, storyController.selection.extentOffset);
//		print(sub);
//	}

	Future<void> share(String text) async {
		await FlutterShare.share(
			title: 'Share Post',
			text: text,
			linkUrl: 'https://plotgen.page.link',
			chooserTitle: 'Please choose'
		);
	}
}
