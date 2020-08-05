import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/ui/screen/addProjectScreen.dart';
import 'package:plotgenerator/ui/screen/addPromptScreen.dart';

import '../../engine/colors.dart';
import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';

const String testDevices = 'your_device_id';
class PromptsScreen extends StatefulWidget {
	@override
	PromptsScreenState createState() => PromptsScreenState();
}

class PromptsScreenState extends State<PromptsScreen> {

	List<Color> promptBackground = [ColorConstants.color_trigger_1, ColorConstants.color_trigger_2, ColorConstants.color_trigger_3, ColorConstants.color_trigger_4, ColorConstants.color_trigger_5];
	int promptIndex = -1;

	BannerAd myBanner;
	MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//		keywords: <String>['flutterio', 'beautiful apps'],
//		contentUrl: 'https://flutter.io',
//		childDirected: false,
		testDevices: testDevices != null ? <String>['testDevices'] : null,
	);

	@override
	void initState() {
		super.initState();
		promptIndex = -1;

		if (!Common.isPAU) {
			myBanner = BannerAd(
				// Replace the testAdUnitId with an ad unit id from the AdMob dash.
				// https://developers.google.com/admob/android/test-ads
				// https://developers.google.com/admob/ios/test-ads
				adUnitId: BannerAd.testAdUnitId,
				size: AdSize.smartBanner,
				targetingInfo: targetingInfo,
				listener: (MobileAdEvent event) {
					if (mounted){
						myBanner..show(
							anchorOffset: 10.0,
							horizontalCenterOffset: 0.0,
							anchorType: AnchorType.bottom
						);
					} else {
						myBanner = null;
					}
				},
			)..load();
		}
	}

	@override
	void dispose() async{
		try {
			myBanner.dispose();
		} catch (ex) {}
		super.dispose();
	}

	@override
	void deactivate(){
		try {
			myBanner.dispose();
		} catch (ex) {}
		super.deactivate();
	}

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) {
		promptIndex = -1;
	}

	gotoMainScreen(BuildContext context) {
		try {
			myBanner.dispose();
		} catch (ex) {}
		Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
	}

	gotoProfileScreen(BuildContext context) {
		try {
			myBanner.dispose();
		} catch (ex) {}
		Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
	}

	gotoPremiumScreen(BuildContext context) {
		try {
			myBanner.dispose();
		} catch (ex) {}
		Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumScreen()));
	}

	gotoDiscoverScreen(BuildContext context) {
		try {
			myBanner.dispose();
		} catch (ex) {}
		Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
	}

	gotoChallengeScreen(BuildContext context) {
		try {
			myBanner.dispose();
		} catch (ex) {}
		Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeScreen()));
	}

	gotoPromptsScreen(BuildContext context) {
		try {
			myBanner.dispose();
		} catch (ex) {}
		Navigator.push(context, MaterialPageRoute(builder: (context) => PromptsScreen()));
	}

	gotoAddPromptScreen(BuildContext context) {
		try {
			myBanner.dispose();
		} catch (ex) {}
		Navigator.push(context, MaterialPageRoute(builder: (context) => AddPromptScreen()));
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
				title: Text(S.of(context).trigger_tab),
			),
			body: Stack(
				children: <Widget>[
					Container(
						child: StreamBuilder(
							stream: Common.currentLanguageEnglish ?
							Firestore.instance.collection('triggers').document('0').collection('special').where('selected', isEqualTo: true).snapshots() :
							Firestore.instance.collection('triggers_es').document('0').collection('special').where('selected', isEqualTo: true).snapshots(),
							builder: (context, snapshot) {
								if (snapshot.hasData) {
									return ListView.builder(
										itemBuilder: (context, index) =>
											buildItem(context, snapshot.data.documents[index]),
										itemCount: snapshot.data.documents.length,
									);
								} else {
									return Center(child: Text('No internet connection!'));
								}
							},
						),
					),
				],
			),
			floatingActionButton: Container(
				padding: EdgeInsets.only(bottom: 100),
				child: FloatingActionButton(
					child: Padding(
						padding: EdgeInsets.all(5),
						child: IconButton(
							icon: Icon(Icons.add),
							onPressed: (){
								gotoAddPromptScreen(context);
							},
						),
					)
				),
			)

		);
	}



	Widget buildItem(BuildContext context, DocumentSnapshot document) {
		promptIndex++;
		if ( promptIndex >= promptBackground.length )
			promptIndex = 0;
		Map<String, dynamic> userInfoMap = Map<String, dynamic>.from(document.data['user']);
		String userName = userInfoMap['name'];
		userName = "By " + userName;
		double width = MediaQuery.of(context).size.width;
		return Container(
			height: 300.0,
			child: FlatButton(
				child: Stack(
					overflow: Overflow.visible,
					children: <Widget>[
						SizedBox(
							width: width,
							height: 300,
							child: Center(
								child: Text(document.data['story'], style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'roboto_thin'),),
							),
						),
						Positioned(
							child: Text( userName, style: TextStyle(color: Colors.white, fontFamily: 'typewcond_regular')),
							right: 10,
							bottom: 20,
						),
					],
				),
				onPressed: () {},
				color: promptBackground[promptIndex],
			),
//				margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
//      padding: EdgeInsets.all(0.0),
		);
	}
}

