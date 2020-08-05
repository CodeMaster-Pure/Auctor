import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/model/OffChallenge.dart';
import 'package:plotgenerator/ui/screen/challengeScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';

import 'discoverScreen.dart';
import 'offCharacterDetailScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class OffChallengeAnswerScreen extends StatefulWidget {
	OffChallengeAnswerScreen();
	@override
	OffChallengeAnswerScreenState createState() => OffChallengeAnswerScreenState();
}

class OffChallengeAnswerScreenState extends State<OffChallengeAnswerScreen> {

	OffChallengeAnswerScreenState();

	final answer1Controller = TextEditingController();
	final answer2Controller = TextEditingController();
	final answer3Controller = TextEditingController();
	final answer4Controller = TextEditingController();

	@override
	void initState() {
		super.initState();
	}

	@override
	void dispose() {
		answer1Controller.dispose();
		answer2Controller.dispose();
		answer3Controller.dispose();
		answer4Controller.dispose();
		super.dispose();
	}

	gotoMainScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
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

	gotoOfflineTemplateScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => OffCharacterDetailScreen()));
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
				title: Text(''),
			),
			body: bodyContainer(),
			floatingActionButton: FloatingActionButton(
				child: IconButton(
					icon: Icon(Icons.save),
					onPressed: (){
						onSave();
					},
				)
			),
		);
	}

	bodyContainer() {
		return SingleChildScrollView(
			padding: EdgeInsets.all(10.0),
			child: Column(
				children: <Widget>[
					Text(Common.currentCharacter.name, style: TextStyle(fontSize: 18),),
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							SizedBox(height: 30,),
							Text(Common.currentModelTemp.q1, style: TextStyle(color: Common.containerBackColor),),
							SizedBox(height: 10,),
							TextField(
								decoration: InputDecoration(
									hintText: 'Answer...'
								),
								style: TextStyle(color: Common.containerBackColor, fontSize: 14),
								onChanged: (value) {},
								controller: answer1Controller,
								maxLines: 10,
							),
							SizedBox(height: 10,),
							Text(Common.currentModelTemp.q2, style: TextStyle(color: Common.containerBackColor)),
							SizedBox(height: 10),
							TextField(
								decoration: InputDecoration(
									hintText: 'Answer...'
								),
								style: TextStyle(color: Common.containerBackColor, fontSize: 14,),
								onChanged: (value) {},
								controller: answer2Controller,
								maxLines: 10,
							),
							SizedBox(height: 10,),
							Text(Common.currentModelTemp.q3, style: TextStyle(color: Common.containerBackColor)),
							SizedBox(height: 10,),
							TextField(
								decoration: InputDecoration(
									hintText: 'Answer...'
								),
								style: TextStyle(color: Common.containerBackColor, fontSize: 14),
								onChanged: (value) {},
								controller: answer3Controller,
								maxLines: 10,
							),
							SizedBox(height: 10,),
							Text(Common.currentModelTemp.q4, style: TextStyle(color: Common.containerBackColor)),
							SizedBox(height: 10,),
							TextField(
								decoration: InputDecoration(
									hintText: 'Answer...'
								),
								style: TextStyle(color: Common.containerBackColor, fontSize: 14),
								onChanged: (value) {},
								controller: answer4Controller,
								maxLines: 10,
							),
						],
					),
				],
			),
		);
	}
	

	onSave() {
		if ( checkUpdateStatus() ) { /// new adding
			OffChallenge offChallenge = new OffChallenge(
				challengeID: Common.currentModelTemp.index,
				characterID: Common.currentCharacter.id.toString(),
				q1: answer1Controller.text,
				q2: answer2Controller.text,
				q3: answer3Controller.text,
				q4: answer4Controller.text
			);

			DatabaseHelper().createOffChallenge(offChallenge).then((result){
					if (result == null) {
						Fluttertoast.showToast(msg: 'Failed Offline Challenge!');
					} else {
						Fluttertoast.showToast(msg: 'Created Offline Challenge!');
						int challengeDone = Common.currentCharacter.challengesDone;
						challengeDone++;
						
						Common.currentCharacter.challengesDone = challengeDone;
						Common.currentCharacter.project_id = Common.currentProject.id.toString();
						DatabaseHelper().updateCharacter(Common.currentCharacter).then((value){
								Fluttertoast.showToast(msg: 'Updated Offline Challenge Percent!');
						});
					}

			});
		} else { /// edit

		}
		gotoMainScreen(context);
	}
	
	bool checkUpdateStatus() {
		return true;
	}

}