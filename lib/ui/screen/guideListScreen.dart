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
import 'package:plotgenerator/model/herojourney.dart';
import 'package:plotgenerator/ui/screen/addProjectScreen.dart';
import 'package:plotgenerator/ui/screen/challengeReadScreen.dart';
import 'package:plotgenerator/ui/screen/challengeScreen.dart';
import 'package:plotgenerator/ui/screen/guideScreens/guideAntagonistScreen.dart';
import 'package:plotgenerator/ui/screen/guideScreens/guideHeroJourneyScreen.dart';
import 'package:plotgenerator/ui/screen/guideScreens/guideLajosScreen.dart';
import 'package:plotgenerator/ui/screen/guideScreens/guideRoleScreen.dart';
import 'package:plotgenerator/ui/screen/guideScreens/guideWeilandScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../engine/colors.dart';
import '../../engine/tutorialManager.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

const String testDevices = 'your_device_id';
class GuideListScreen extends StatefulWidget {

	GuideListScreen();

	@override
	GuideListScreenState createState() => GuideListScreenState();
}

class GuideListScreenState extends State<GuideListScreen> {

	BannerAd myBanner;
	MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//		keywords: <String>['flutterio', 'beautiful apps'],
//		contentUrl: 'https://flutter.io',
//		childDirected: false,
		testDevices: testDevices != null ? <String>['testDevices'] : null,
	);

	List<Herojourney> mList = [];


	@override
	void initState() {
		super.initState();
		Future.delayed(Duration.zero, this.loadHeroList);
		if (!Common.isPAU) {
			myBanner = BannerAd(
				// Replace the testAdUnitId with an ad unit id from the AdMob dash.
				// https://developers.google.com/admob/android/test-ads
				// https://developers.google.com/admob/ios/test-ads
				adUnitId: BannerAd.testAdUnitId,
				size: AdSize.smartBanner,
				targetingInfo: targetingInfo,
				listener: (MobileAdEvent event) {
					if ( event == MobileAdEvent.loaded) {
						if (mounted){
							myBanner..show(
								anchorOffset: 10.0,
								horizontalCenterOffset: 0.0,
								anchorType: AnchorType.bottom
							);
						} else {
							myBanner = null;
						}
					}
				},
			)..load();
		}
	}

	@override
	void dispose() {
		try {
			myBanner.dispose();
		} catch (ex) {}
		super.dispose();
	}

	loadHeroList(){
		setState(() {
			mList.clear();
			mList.add(new Herojourney(ColorConstants.color_trigger_1, S.of(context).roles_title, S.of(context).roles_desc, S.of(context).roles_desc_long));
			mList.add(new Herojourney(ColorConstants.color_trigger_2, S.of(context).lajos_character_title, S.of(context).lajos_character_desc, S.of(context).lajos_character_long));
			mList.add(new Herojourney(ColorConstants.color_trigger_3, S.of(context).change_arc_title, S.of(context).change_arc_desc, S.of(context).change_arc_desc_long));
			mList.add(new Herojourney(ColorConstants.color_trigger_4, S.of(context).antagonist_guide_title, S.of(context).antagonist_guide_desc, S.of(context).antagonist_guide_desc_long));
			mList.add(new Herojourney(ColorConstants.color_trigger_5, S.of(context).herojourney_guide_title, S.of(context).herojourney_guide_desc, S.of(context).herojourney_guide_desc_long));
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
		Navigator.push(context, MaterialPageRoute(builder: (context) => PromptsScreen()));
	}

	gotoGuideDetailScreen(BuildContext context, String title) {
		try {
			myBanner.dispose();
		} catch (ex) {}

		if (title == S.of(context).roles_title) {
			Navigator.push(context, MaterialPageRoute(builder: (context) => GuideRoleScreen()));
		} else if (title == S.of(context).lajos_character_title) {
			Navigator.push(context, MaterialPageRoute(builder: (context) => GuideLajosScreen()));
		} else if (title == S.of(context).change_arc_title) {
			Navigator.push(context, MaterialPageRoute(builder: (context) => GuideWeilandScreen()));
		} else if (title == S.of(context).antagonist_guide_title) {
			Navigator.push(context, MaterialPageRoute(builder: (context) => GuideAntagonistScreen()));
		} else if (title == S.of(context).herojourney_guide_title) {
			Navigator.push(context, MaterialPageRoute(builder: (context) => GuideHeroJourneyScreen()));
		}
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
								child: Image.asset(ImageConstants.SideMenuPremium, color: ColorConstants.colorPrimaryDark),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).writing_challenge_tab),
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
				title: Text(S.of(context).guide_character_btn),
			),
			body: SingleChildScrollView(
				child: Column(
					children: List.generate(mList.length, (index){
						return buildItem(context, index);
					})
				),
			)
		);
	}

	Widget buildItem(BuildContext context, index) {
		double width = MediaQuery.of(context).size.width;
		return Container(
			decoration: BoxDecoration(
			gradient: LinearGradient(
				begin: Alignment.topCenter,
				end: Alignment.bottomCenter,
				colors: [mList[index].background, Colors.black]
			)
		),
			width: width,
			height: 500,
			child: FlatButton(
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>[
						Container(
							alignment: Alignment.centerLeft,
							width: width,
							height: 50,
							child: Padding(
								padding: EdgeInsets.all(10),
								child: Text(mList[index].herojourney_act, style: TextStyle(color: Colors.white, fontFamily: 'roboto_bolditalic', fontSize: 24),),
							),
							color: Colors.black,
						),
						Padding(
							padding: EdgeInsets.all(10),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisAlignment: MainAxisAlignment.start,
								children: <Widget>[
									SizedBox(height: 10,),
									Text(mList[index].herojourney_title, style: TextStyle(color: Colors.white, fontFamily: 'roboto_italic', fontSize: 20),),
									SizedBox(height: 20,),
									Text(mList[index].herojourney_desc, style: TextStyle(color: Colors.white, fontFamily: 'roboto_regular', fontSize: 20),)
								],
							),
						),


					],
				),
				onPressed: () {
					gotoGuideDetailScreen(context, mList[index].herojourney_title);
				},
				padding: EdgeInsets.all(0.0),
			),
		);
	}

}