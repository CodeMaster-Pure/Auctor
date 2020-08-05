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

import '../../../engine/colors.dart';
import '../../../model/herojourney.dart';
import '../../../main.dart';
import '../challengeScreen.dart';
import '../discoverScreen.dart';
import '../premiumScreen.dart';
import '../profileScreen.dart';

const String testDevices = 'your_device_id';
class GuideLajosScreen extends StatefulWidget {
	@override
	GuideLajosScreenState createState() => GuideLajosScreenState();
}

class GuideLajosScreenState extends State<GuideLajosScreen> {

	final textController = TextEditingController();
	String lajosString = '';
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

		Future.delayed(Duration.zero, this.loadInformation);
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

	}

	loadInformation(){
		setState(() {
			lajosString = S.of(context).lajos_text;
		});
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
		Navigator.push(context, MaterialPageRoute(builder: (context) => GuideLajosScreen()));
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
				title: Text(S.of(context).lajos_character_title),
			),
			body: buildItem(context)
		);
	}

	Widget buildItem(BuildContext context) {
		double width = MediaQuery.of(context).size.width;

		return SingleChildScrollView(
			padding: EdgeInsets.all(10.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Text(S.of(context).lajos_character_title, style: TextStyle(color: ColorConstants.headline, fontSize: 24, fontFamily: 'roboto_lightitalic' ),),
					SizedBox(height: 20),
					SingleChildScrollView(
						child: Text(S.of(context).lajos_text, style: TextStyle(fontSize: 20),),
					)
				],
			)
		);
	}
}

