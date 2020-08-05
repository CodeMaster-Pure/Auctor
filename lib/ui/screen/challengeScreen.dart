import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/model/user.dart';
import 'package:plotgenerator/ui/screen/addProjectScreen.dart';
import 'package:plotgenerator/ui/screen/challengeReadScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';
import 'package:plotgenerator/ui/screen/submitStoryScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../engine/colors.dart';
import '../../engine/tutorialManager.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

const String testDevices = 'your_device_id';
class ChallengeScreen extends StatefulWidget {
	ChallengeScreen();

	@override
	ChallengeScreenState createState() => ChallengeScreenState();
}

class ChallengeScreenState extends State<ChallengeScreen> {

	String ad_submite_btn;
	bool can_submit = false;

	RewardedVideoAd videoAd = RewardedVideoAd.instance;
	MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//		keywords: <String>['flutterio', 'beautiful apps'],
//		contentUrl: 'https://flutter.io',
//		childDirected: false,
		testDevices: testDevices != null ? <String>['testDevices'] : null,
	);

	@override
	void initState() {
		super.initState();
		Future.delayed(Duration.zero, this.getButtonInfo);
		FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
	}

	@override
	void dispose() {
		super.dispose();
	}

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) {

	}

	getButtonInfo() {
		setState(() {
			if (!Common.isPAU)
				ad_submite_btn = S.of(context).weekly_challenge_view_ad_btn.toUpperCase();
			else
				ad_submite_btn = S.of(context).weekly_challenge_submit_btn.toUpperCase();
		});
	}

	GoogleSignIn _googleSignIn = GoogleSignIn();
	bool login() {
		_handleSignIn().then((FirebaseUser user) {
			Common.currentFirebaseUser = user;
			Common.currentUser = new User(uid: user.uid, name: user.displayName, email: user.email, uriString: user.photoUrl);
			return true;
		}).catchError((e) {
			Helper.showErrorToast(e.toString());
		});
	}

	Future<FirebaseUser> _handleSignIn() async {
		final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
		final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

		final AuthCredential credential = GoogleAuthProvider.getCredential(
			accessToken: googleAuth.accessToken,
			idToken: googleAuth.idToken,
		);

		FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
		return user;
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

	gotoSubmitStoryScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitStoryScreen()));
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
				title: Text('Weekly writing Challenge'),
			),
			body: new DefaultTabController(
				length: 2,
				child: new Scaffold(
					appBar: new AppBar(
						actions: <Widget>[],
						title: new TabBar(
							tabs: [
								Padding(
									padding: EdgeInsets.all(19.0),
									child: new Text('ON GOING',),
								),
								Padding(
									padding: EdgeInsets.all(19.0),
									child: new Text('LAST WINNER'),
								),

							],

							indicatorColor: Colors.white,
						),
						automaticallyImplyLeading: false,
					),
					body: new TabBarView(
						children: [
							StreamBuilder(
								stream: Common.currentLanguageEnglish ? Firestore.instance.document('weekly_challenge/current').snapshots() : Firestore.instance.document('weekly_challenge_es/current').snapshots(),
								builder: (context, snapshot) {
									if (!snapshot.hasData) { return Text(S.of(context).weekly_challenge_title_default, style: TextStyle(fontFamily: 'roboto_lightitalic', fontSize: 25),); }
									else {
										Common.currentWeeklyStoryTitle = snapshot.data['title'];
										return new Column(
											crossAxisAlignment: CrossAxisAlignment.center,
											children: <Widget>[
												Expanded(
													child: SizedBox(
														child: ListView(
															children: <Widget>[
																SizedBox(height: 20,),
																Text(Common.currentWeeklyStoryTitle, style: TextStyle(fontSize: 24, fontFamily: 'roboto_lightitalic'), textAlign: TextAlign.center,),
																Padding(
																	padding: EdgeInsets.all(20),
																	child: new Text(snapshot.data['body'], style: TextStyle(color: Common.containerBackColor, fontSize: 18, fontFamily: 'roboto_regular'),),
																),
															],
														),
													),
												),
												Padding(
													padding: EdgeInsets.all(19.0),
													child: new Text(S.of(context).challenge_ongoing_ad_en, style: TextStyle(fontFamily: 'typewcond_regular', color: Common.containerBackColor),),
												),
												Row(children: <Widget>[
													Expanded(
														child: Padding(
															padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
															child: new MaterialButton(
																height: 50.0,
																color: Common.containerBackColor,
																textColor: Colors.white,
																child: new Text(ad_submite_btn),
																onPressed: () {
																	if (Common.isPAU)
																		gotoSubmitStoryScreen(context);
																	else {
																		checkSignStatusForSubmitStory().then((value){
																			if (value){
																				if (!can_submit) {
																					videoAd.load(adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo).then((result){
																						if (result){
																							videoAd.show();
																						}
																					});
																					videoAd.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
																						if (event == RewardedVideoAdEvent.rewarded) {
																							setState(() {
																								ad_submite_btn = S.of(context).weekly_challenge_submit_btn.toUpperCase();
																								can_submit = true;
																							});
																						}
																					};
																				} else {
																					gotoSubmitStoryScreen(context);
																				}
																			}
																		});
																	}
																},
															),
														)
													),
													Expanded(
														child: Padding(
															padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
															child: new MaterialButton(
																height: 50.0,
																color: Common.containerBackColor,
																textColor: Colors.white,
																child: new Text("READ"),
																onPressed: () => { checkSignStatus() },
															),
														)
													),
												])
											],
											mainAxisAlignment: MainAxisAlignment.center,
										);
									}
								},
							),

							///Last Winner
							StreamBuilder(
								stream: Common.currentLanguageEnglish ? Firestore.instance.document('weekly_winners/current').snapshots() : Firestore.instance.document('weekly_winner_es/current').snapshots(),
								builder: (context, snapshot) {
									if (!snapshot.hasData) { return Text(S.of(context).weekly_challenge_desc_default); }
									else {
										String body = snapshot.data['body'];
										String body_fix = body.replaceAll("\\n", "\n");
										String author = snapshot.data['author'];
										author = S.of(context).weekly_challenge_author + ' - ' + author;
										return new Column(
											crossAxisAlignment: CrossAxisAlignment.center,
											children: <Widget>[
												Expanded(
													child: SizedBox(
														child: ListView(
															children: <Widget>[
																SizedBox(height: 20,),
																Text(snapshot.data['title'], style: TextStyle(fontSize: 24, fontFamily: 'roboto_lightitalic'), textAlign: TextAlign.center,),
																SizedBox(height: 10,),
																Text(author, style: TextStyle(color: Common.containerBackColor, fontSize: 18, fontFamily: 'roboto_regular'), textAlign: TextAlign.center,),
																Padding(
																	padding: EdgeInsets.all(20),
																	child: new Text(body_fix, style: TextStyle(color: Common.containerBackColor, fontSize: 18, fontFamily: 'roboto_regular'),),
																),
															],
														),
													),
												),
											],
											mainAxisAlignment: MainAxisAlignment.center,
										);
									}
								},
							),
						],
					),
				),
			),
		);
	}

	Future<bool> checkSignStatusForSubmitStory() async {
		if (Common.currentUser == null ) {
			if (login()) {
				return true;
			}
		} else {
			return true;
		}

		return false;
	}

	checkSignStatus() async{
		if (Common.currentFirebaseUser == null ) {
			if (login())
				gotoChallengeReadScreen(context);
		} else {
			gotoChallengeReadScreen(context);
		}
	}

	gotoChallengeReadScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeReadScreen()));
	}

}