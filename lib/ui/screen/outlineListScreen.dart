import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';

import 'package:plotgenerator/engine/database/databaseHelper.dart';

import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/model/Character.dart';

import 'package:plotgenerator/model/Outline.dart';

import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'addOutlineScreen.dart';

import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class OutlineListScreen extends StatefulWidget {

	OutlineListScreen({Key key}) : super(key: key);

	@override
	OutlineListScreenState createState() => OutlineListScreenState();
}

class OutlineListScreenState extends State<OutlineListScreen>  with SingleTickerProviderStateMixin {
	OutlineListScreenState();

	List<Outline> outlines = [];
	List<String> characterPresentList = [];

	@override
	void initState() {
		super.initState();
		for (int i = 0; i < 50; i++ ) {
			characterPresentList.add('');
		}
		Future.delayed(Duration.zero, this.loadOutlines);
	}

	@override
	void dispose() {
		super.dispose();
	}

	loadOutlines() {
		DatabaseHelper().getOutlineByProjectID(Common.currentProject.id.toString()).then((results) {
			setState(() {
				outlines = results;
				for ( int i = 0 ; i < outlines.length; i++) {
					List<String> splitStr = outlines[i].characterPresent.split(',');
					for (String tmp in splitStr) {
						if (tmp == '') {
							continue;
						} else {
							int index = int.parse(tmp);

							for (Character temp in Common.currentCharacterLists ) {
								if ( index == temp.id ) {
									characterPresentList[i] = characterPresentList[i] + temp.name;
								}
							}
						}
					}
				}
			});
		});
	}

	checkTutorial() {
		TutorialManager.check(context);
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

	gotoAddOutlineScreen(BuildContext context, bool check){
		Navigator.push(context, MaterialPageRoute(builder: (context) => AddOutlineScreen(check: check)));
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
				title: Text(S.of(context).add_outline),
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.share),
						onPressed: (){
							if (!Common.isPAU) {
								Fluttertoast.showToast(msg: S.of(context).premiumOnly);
							} else {
								shareText();
							}
						},
					)
				],
			),
			body: (outlines == null || outlines.length <= 0)
				? noOutlineContainer(context)
				: outlineListView(context),
			floatingActionButton: FloatingActionButton(
				child: IconButton(
					icon: Icon(Icons.add,),
					onPressed: () {
						gotoAddOutlineScreen(context, true);
					},
				),
			)
		);
	}

	noOutlineContainer(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Container(
						margin: const EdgeInsets.only(left: 16, right: 16),
						child: Text(
							S.of(context).outline_empty,
							style: TextStyle(
								fontSize: 18,
								color: Colors.black,
							),
						),
					)
				],
			),
		);
	}

	outlineListView(BuildContext context) {
		return Container(
			padding: EdgeInsets.all(8),
			child: ListView.separated(
				itemCount: outlines.length,
				itemBuilder: (context, index) {
					Outline outline = outlines[index];
					print('current index:' + index.toString());
					var width = MediaQuery.of(context).size.width;
					return Container(
						color: Common.containerBackColor,
						child: FlatButton(
							child: Padding(
								padding: EdgeInsets.all(10.0),
								child: Column(
									children: <Widget>[
										SizedBox(
//											height: 40,
											width: width,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisAlignment: MainAxisAlignment.start,
												children: <Widget>[
													Text(outline.name, style: TextStyle(color: Common.currentTheme != 5 ? Colors.black : Colors.white)),
												],
											),
										),
										SizedBox(
											height: 150,
											width: width,
											child: SingleChildScrollView(
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													mainAxisAlignment: MainAxisAlignment.start,
													children: <Widget>[
														Text(outline.description, style: TextStyle(color: Common.currentTheme != 5 ? Colors.black : Colors.white)),
													],
												),
											)
										),
										SizedBox(
//											height: 40,
											width: width,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisAlignment: MainAxisAlignment.start,
												children: <Widget>[
													Text(characterPresentList[index], style: TextStyle(color: Common.currentTheme != 5 ? Colors.black : Colors.white)),
												],
											),
										),

									],
								),
							),
							padding: EdgeInsets.all(0.0),
							onPressed: () {
								Common.currentOutline = outline;
								gotoAddOutlineScreen(context, false);
							},
						)
					);
				},
				separatorBuilder: (context, index) {
					return SizedBox(height: 10,);
				},
			),
		);
	}
	
	Future<void> share(String text) async {
		await FlutterShare.share(
			title: 'Share Post',
			text: text,
			linkUrl: 'https://plotgen.page.link',
			chooserTitle: 'Please choose'
		);
	}
	
	shareText(){
		if ( outlines == null || outlines.length == 0) {
			Fluttertoast.showToast(msg: 'No Outlines');
		} else {
			StringBuffer text = new StringBuffer();
			for (int i = 0; i < outlines.length; i++) {
				text.write('Title:');
				text.writeln(outlines[i].name);
				text.write('Description:');
				text.writeln(outlines[i].description);
				text.write('Character:');
				text.writeln(characterPresentList[i]);
			}
			
			share(text.toString());
		}
	}

}
