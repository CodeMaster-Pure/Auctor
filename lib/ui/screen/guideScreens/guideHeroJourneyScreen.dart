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
class GuideHeroJourneyScreen extends StatefulWidget {
	@override
	GuideHeroJourneyScreenState createState() => GuideHeroJourneyScreenState();
}

class GuideHeroJourneyScreenState extends State<GuideHeroJourneyScreen> {

	List<Herojourney> mlist = [];

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
			mlist.clear();
			mlist.add(new Herojourney(null, S.of(context).hj_title_0, S.of(context).hj_act1, S.of(context).hj_desc_0));
			mlist.add(new Herojourney(null, S.of(context).hj_title_1, S.of(context).hj_act1, S.of(context).hj_desc_1));
			mlist.add(new Herojourney(null, S.of(context).hj_title_2, S.of(context).hj_act1, S.of(context).hj_desc_2));
			mlist.add(new Herojourney(null, S.of(context).hj_title_3, S.of(context).hj_act1, S.of(context).hj_desc_3));
			mlist.add(new Herojourney(null, S.of(context).hj_title_4, S.of(context).hj_act2, S.of(context).hj_desc_4));
			mlist.add(new Herojourney(null, S.of(context).hj_title_5, S.of(context).hj_act2, S.of(context).hj_desc_5));
			mlist.add(new Herojourney(null, S.of(context).hj_title_6, S.of(context).hj_act2, S.of(context).hj_desc_6));
			mlist.add(new Herojourney(null, S.of(context).hj_title_7, S.of(context).hj_act2, S.of(context).hj_desc_7));
			mlist.add(new Herojourney(null, S.of(context).hj_title_8, S.of(context).hj_act2, S.of(context).hj_desc_8));
			mlist.add(new Herojourney(null, S.of(context).hj_title_9, S.of(context).hj_act2, S.of(context).hj_desc_9));
			mlist.add(new Herojourney(null, S.of(context).hj_title_10, S.of(context).hj_act2, S.of(context).hj_desc_10));
			mlist.add(new Herojourney(null, S.of(context).hj_title_11, S.of(context).hj_act3, S.of(context).hj_desc_11));
			mlist.add(new Herojourney(null, S.of(context).hj_title_12, S.of(context).hj_act3, S.of(context).hj_desc_12));
			mlist.add(new Herojourney(null, S.of(context).hj_title_13, S.of(context).hj_act3, S.of(context).hj_desc_13));
			mlist.add(new Herojourney(null, S.of(context).hj_title_14, S.of(context).hj_act3, S.of(context).hj_desc_14));
			mlist.add(new Herojourney(null, S.of(context).hj_title_15, S.of(context).hj_act3, S.of(context).hj_desc_15));
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
		Navigator.push(context, MaterialPageRoute(builder: (context) => GuideHeroJourneyScreen()));
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
				title: Text(S.of(context).hero_journey_tab),
			),
			body: buildItem(context)
		);
	}



	Widget buildItem(BuildContext context) {
		double width = MediaQuery.of(context).size.width;
		return SingleChildScrollView(
			child: Column(
				children: List.generate(mlist.length, (index) {
					int mod = index % 2;
					return Container(
						height: 500,
						child: Stack(
							children: <Widget>[
								SizedBox(
									height: 500,
									child: mod == 0 ? Image.asset(ImageConstants.hero_bkg, fit: BoxFit.cover,) : Image.asset(ImageConstants.hero_bkg2, fit: BoxFit.cover,)
								),
								Positioned(
									child: Container(
										padding: EdgeInsets.only(left: 20),
										alignment: Alignment.centerLeft,
										color: Colors.black87,
										width: width,
										height: 50,
										child: Text(mlist[index].herojourney_act, style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'roboto_bolditalic'),),
									),
									left: 0,
									top: 0,
								),
								Positioned(
									child: Container(
										padding: EdgeInsets.only(left: 20),
										alignment: Alignment.centerLeft,
										width: width,
										child: Text(mlist[index].herojourney_title, style: TextStyle(color: Colors.white, fontFamily: 'roboto_italic', fontSize: 20)),
									),
									left: 0,
									top: 100,
								),
								Positioned(
									child: Container(
										padding: EdgeInsets.only(left: 20),
										alignment: Alignment.centerLeft,
										width: width,
										child: Text(mlist[index].herojourney_desc, style: TextStyle(color: Colors.white, fontSize: 20),),
									),
									left: 0,
									top: 150,
								),

							],
						)

					);
				})
			)
		);
	}
}

