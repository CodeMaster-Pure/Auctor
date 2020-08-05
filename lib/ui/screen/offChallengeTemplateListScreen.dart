import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/modelTemp.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/template.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/ui/screen/addProjectScreen.dart';
import 'package:plotgenerator/ui/screen/challengeReadScreen.dart';
import 'package:plotgenerator/ui/screen/challengeScreen.dart';
import 'package:plotgenerator/ui/screen/offChallengeAnswerScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../engine/colors.dart';
import '../../engine/tutorialManager.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class OffChallengeTemplateListScreen extends StatefulWidget {
	OffChallengeTemplateListScreen();

	@override
	OffChallengeTemplateListScreenState createState() => OffChallengeTemplateListScreenState();
}

class OffChallengeTemplateListScreenState extends State<OffChallengeTemplateListScreen> {

	List<ModelTemp> resultLists = [];
	@override
	void initState() {
		super.initState();
		resultLists = [];
		loadInformation();
	}

	@override
	void dispose() {
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

	gotoOffChallengeAnswerScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => OffChallengeAnswerScreen()));
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
									S.of(context).biocontainer_challenge,
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
				title: Text(S.of(context).biocontainer_challenge),
			),
			body: bodyContainer()
		);
	}

	loadInformation(){
		resultLists = [];

		if ( Common.currentCharacter != null) {
			switch (Common.currentCharacter.role) {
				case 'Mentor':
					addNewChallenge("mentor_challenge","recommendedAct1");
					break;
				case "Escudero":
					addNewChallenge("sidekick_challenge","recommendedAct1");
					break;
				case "Antagonista":
					addNewChallenge("antagonist_challenge","recommendedAct1");
					break;
				case "Protagonista":
					addNewChallenge("protagonist_challenge","recommendedAct1");
					break;
			}
		}

		addNewChallenge("challenge_1","Act1");
		addNewChallenge("challenge_9","Act1");
		addNewChallenge("challenge_4","Act1");
		addNewChallenge("challenge_6","Act1");
		addNewChallenge("challenge_10","Act1");
		addNewChallenge("challenge_2","Act2");
		addNewChallenge("challenge_3","Act2");
		addNewChallenge("challenge_5","Act2");
		addNewChallenge("challenge_7","Act2");
		addNewChallenge("challenge_8","Act3");
	}

	addNewChallenge(String challengeNumber, String actNumber){
		switch ( challengeNumber ) {
			case 'mentor_challenge':
				ModelTemp modelTemp = new ModelTemp(index: Mentor().index, title: Mentor().title, act_kind: actNumber, q1: Mentor().q1, q2: Mentor().q2, q3: Mentor().q3, q4: Mentor().q4, q5: Mentor().q5);
				resultLists.add(modelTemp);
				break;
			case 'sidekick_challenge' :
				ModelTemp modelTemp = new ModelTemp(index: Sidekick().index, title: Sidekick().title, act_kind: actNumber, q1: Sidekick().q1, q2: Sidekick().q2, q3: Sidekick().q3, q4: Sidekick().q4, q5: Sidekick().q5);
				resultLists.add(modelTemp);
				break;
			case 'antagonist_challenge' :
				ModelTemp modelTemp = new ModelTemp(index: Antagonist().index,title: Antagonist().title, act_kind: actNumber, q1: Antagonist().q1, q2: Antagonist().q2, q3: Antagonist().q3, q4: Antagonist().q4, q5: Antagonist().q5);
				resultLists.add(modelTemp);
				break;
			case 'protagonist_challenge' :
				ModelTemp modelTemp = new ModelTemp(index: Protagonist().index,title: Protagonist().title, act_kind: actNumber, q1: Protagonist().q1, q2: Protagonist().q2, q3: Protagonist().q3, q4: Protagonist().q4, q5: Protagonist().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_1' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_1().index,title: Challenge_1().title, act_kind: actNumber, q1: Challenge_1().q1, q2: Challenge_1().q2, q3: Challenge_1().q3, q4: Challenge_1().q4, q5: Challenge_1().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_2' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_2().index, title: Challenge_2().title, act_kind: actNumber, q1: Challenge_2().q1, q2: Challenge_2().q2, q3: Challenge_2().q3, q4: Challenge_2().q4, q5: Challenge_2().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_3' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_3().index,title: Challenge_3().title, act_kind: actNumber, q1: Challenge_3().q1, q2: Challenge_3().q2, q3: Challenge_3().q3, q4: Challenge_3().q4, q5: Challenge_3().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_4' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_4().index,title: Challenge_4().title, act_kind: actNumber, q1: Challenge_4().q1, q2: Challenge_4().q2, q3: Challenge_4().q3, q4: Challenge_4().q4, q5: Challenge_4().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_5' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_5().index,title: Challenge_5().title, act_kind: actNumber, q1: Challenge_5().q1, q2: Challenge_5().q2, q3: Challenge_5().q3, q4: Challenge_5().q4, q5: Challenge_5().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_6' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_6().index,title: Challenge_6().title, act_kind: actNumber, q1: Challenge_6().q1, q2: Challenge_6().q2, q3: Challenge_6().q3, q4: Challenge_6().q4, q5: Challenge_6().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_7' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_7().index,title: Challenge_7().title, act_kind: actNumber, q1: Challenge_7().q1, q2: Challenge_7().q2, q3: Challenge_7().q3, q4: Challenge_7().q4, q5: Challenge_7().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_8' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_8().index,title: Challenge_8().title, act_kind: actNumber, q1: Challenge_8().q1, q2: Challenge_8().q2, q3: Challenge_8().q3, q4: Challenge_8().q4, q5: Challenge_8().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_9' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_9().index,title: Challenge_9().title, act_kind: actNumber, q1: Challenge_9().q1, q2: Challenge_9().q2, q3: Challenge_9().q3, q4: Challenge_9().q4, q5: Challenge_9().q5);
				resultLists.add(modelTemp);
				break;
			case 'challenge_10' :
				ModelTemp modelTemp = new ModelTemp(index: Challenge_10().index,title: Challenge_10().title, act_kind: actNumber, q1: Challenge_10().q1, q2: Challenge_10().q2, q3: Challenge_10().q3, q4: Challenge_10().q4, q5: Challenge_10().q5);
				resultLists.add(modelTemp);
				break;
		}
	}

	bodyContainer(){
		return Container(
			padding: EdgeInsets.all(8),
			child: ListView.builder(
				itemCount: resultLists.length,
				scrollDirection: Axis.vertical,
				itemExtent: 280.0,
				itemBuilder: (context, index) {
					ModelTemp modelTemp = resultLists[index];
					return ListTile(
						title: Container(
							padding: EdgeInsets.all(5.0),
							margin: EdgeInsets.only(bottom: 10.0),
							color: Common.containerBackColor,
							child: Column(
								children: <Widget>[
									Row(
										children: <Widget>[
											SizedBox(
												width: 90,
												height: 90,
												child: Image.asset(ImageConstants.challenge_icon),
											),
											SizedBox(
												width: 10,
											),
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: <Widget>[
													Text('Title', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'roboto_regular')),
													Text(modelTemp.title, style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'roboto_regular')),
													Text('Recommended:', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'roboto_regular')),
													Text(modelTemp.act_kind, style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'roboto_regular')),
												],
											)
										],
									),
									SizedBox(
										height: 120,
										child: Text(modelTemp.q1, maxLines: 10, style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'roboto_black'),),
									),

									SizedBox(
										width: double.infinity,
										child: OutlineButton(
											child: Text('Let\'s do it', style: TextStyle(color: Colors.white),),
											onPressed: (){
												Common.currentModelTemp = modelTemp;
												gotoOffChallengeAnswerScreen(context);
											},
											shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
											borderSide: BorderSide(color: Colors.white),
										),
									),


								],
							),

						),
						onTap: () {}
					);
				},
//				separatorBuilder: (context, index) {
//					return Divider();
//				},
			),
		);
	}

}