import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/model/Project.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/imagePicker.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/model/Outline.dart';
import 'package:plotgenerator/model/Story.dart';
import 'package:plotgenerator/model/user.dart';
import 'package:plotgenerator/ui/screen/outlineListScreen.dart';

import '../../engine/colors.dart';
import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class SubmitStoryScreen extends StatefulWidget {
	SubmitStoryScreen({Key key}) : super(key: key);

	@override
	SubmitStoryScreenState createState() => SubmitStoryScreenState();
}

class SubmitStoryScreenState extends State<SubmitStoryScreen> {

	SubmitStoryScreenState();

	final titleController = TextEditingController();
	final storyController = TextEditingController();

	@override
	void initState() {
		super.initState();
		titleController.text = Common.currentWeeklyStoryTitle;
	}

	@override
	void dispose() {
		titleController.dispose();
		storyController.dispose();
		super.dispose();
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
								decoration: BoxDecoration(color: MetalTheme.backgroundDarker)),
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
				title: Text(S.of(context).submit_your_challenge),
			),
			body: bodyContainer(),
			persistentFooterButtons: <Widget>[
				SizedBox(
					width: MediaQuery.of(context).size.width,
					height: 50,
					child: RaisedButton(
						color: Common.containerBackColor,
						child: Text(S.of(context).submit_button.toUpperCase()),
						onPressed: (){
							save();
						},
					),
				)
			],
		);
	}

	bodyContainer() {
		return Container(
			padding: EdgeInsets.all(10.0),
			child: ConstrainedBox(
				constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						SizedBox(
							height: 20,
						),
						Text(S.of(context).submit_welcome, style: TextStyle(fontFamily: 'roboto_bold', fontSize: 24, ),),
						SizedBox(
							height: 10,
						),
						Text(Common.currentUser.name, style: TextStyle(fontSize: 20, fontFamily: 'roboto_regular', color: Common.containerBackColor),),
						TextField(
							enabled: false,
							onTap: (){
								FocusScope.of(context).requestFocus(new FocusNode());
							},
							decoration: InputDecoration(
								labelText: S.of(context).submit_title,
							),
							style: TextStyle( fontSize: 18, fontFamily: 'roboto_bold'),
							onChanged: (value) {},
							controller: titleController,
							maxLines: 1,
						),
						TextField(
							decoration: InputDecoration(
								hintText: S.of(context).write_here_hint
							),
							style: TextStyle(color: Common.containerBackColor, fontSize: 18, fontFamily: 'roboto_light'),
//							cursorColor: Colors.black,
							onChanged: (value) {},
							controller: storyController,
							maxLines: 5,
						),
						Padding(
							padding: EdgeInsets.only(top: 20),
							child: Text(S.of(context).submit_prompt, style: TextStyle(fontFamily: 'roboto_bold', fontSize: 20),),
						)
					],
				),
			)
		);
	}

	Future<bool> save() async {
		if (Common.currentUser != null ) {
			String id = Firestore.instance
				.collection(S.of(context).weekly_challenge_db_name)
				.document(Common.currentWeeklyStoryTitle)
				.collection('posts')
				.document()
				.documentID;

			int date = (DateTime
				.now()
				.millisecondsSinceEpoch / 1000).round();

			Story story = new Story(
				id: id,
				challenge: storyController.text,
				date: date,
				genre: '',
				likeCount: 0,
				published: false,
				title: Common.currentWeeklyStoryTitle,
				viewCount: 0,
				likesMap: new Map<String, bool>.identity(),
				user: new User(
					uid: Common.currentUser.uid,
					email: Common.currentUser.email,
					name: Common.currentUser.name,
					uriString: Common.currentUser.uriString
				).toMap()
			);

			try {
				if ( Common.currentLanguageEnglish) {
					Firestore.instance.document(S
						.of(context)
						.weekly_challenge_db_name + '/' +
						Common.currentWeeklyStoryTitle + '/posts/$id').setData(
						story.toMap()).then((result) {
						Fluttertoast.showToast(msg: 'Added Story!');
						gotoChallengeScreen(context);
					});
				} else {
					Firestore.instance.document('weekly_participants_es/' +
						Common.currentWeeklyStoryTitle + '/posts/$id').setData(
						story.toMap()).then((result) {
						Fluttertoast.showToast(msg: 'Added Story!');
						gotoChallengeScreen(context);
					});
				}
			}  catch (e) {
				// throw the Firebase AuthException that we caught
				throw new Exception(e.toString());
			}
		} else {
			Fluttertoast.showToast(msg: 'Please login in Profile Section');
			return false;
		}
	}
}
