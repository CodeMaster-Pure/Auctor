import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/template.dart';
import 'package:plotgenerator/engine/utility.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/model/OffChallenge.dart';
import 'package:plotgenerator/model/Timeline.dart';
import 'package:plotgenerator/ui/screen/editCharacterScreen.dart';
import 'package:plotgenerator/ui/screen/offChallengeTemplateListScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';
import 'package:plotgenerator/ui/screen/addTimeLineScreen.dart';

import '../../engine/tutorialManager.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'guideListScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class OffCharacterDetailScreen extends StatefulWidget {
	OffCharacterDetailScreen();
	@override
	OffCharacterDetailScreenState createState() => OffCharacterDetailScreenState();
}

class OffCharacterDetailScreenState extends State<OffCharacterDetailScreen> with SingleTickerProviderStateMixin {
	OffCharacterDetailScreenState();

	TabController tabController;
	bool isOpened = false;

	List<OffChallenge> offChallenges = [];
	List<Timeline> timeLines = [];

	@override
	void initState() {
		super.initState();
		tabController = TabController(length: 3, vsync: this, initialIndex: 0);
		tabController.addListener(_handleTabIndex);
		Future.delayed(Duration.zero, this.loadChallenges);
		Future.delayed(Duration.zero, this.loadTimeLines);
		Future.delayed(Duration.zero, this.checkTutorial);
	}

	@override
	void dispose() {
		super.dispose();
		tabController.removeListener(_handleTabIndex);
		tabController.dispose();
	}

	void _handleTabIndex() {
		setState(() {});
	}

	loadChallenges(){
		DatabaseHelper().getChallengesByID(Common.currentCharacter.id.toString()).then((result){
			setState(() {
				offChallenges = result;
			});
		});
	}

	loadTimeLines() {
		DatabaseHelper().getTimeLinesByID(Common.currentCharacter.id.toString()).then((result){
			setState(() {
			  timeLines = result;
			});
		});
	}

	checkTutorial() {
		TutorialManager.check(context);
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

	gotoGuideListScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => GuideListScreen()));
	}

	gotoOffChallengeTemplateScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => OffChallengeTemplateListScreen()));
	}

	gotoAddTimeLineScreen(BuildContext context, bool isNew) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => AddTimeLineScreen(isNew: isNew,)));
	}

	gotoEditCharacterScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => EditCharacterScreen()));
	}



	@override
	Widget build(BuildContext context) {
		return SafeArea(
			top: false,
			child: Scaffold(
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
					actions:  <Widget>[
						IconButton(
							icon: Icon(Icons.info_outline),
							onPressed: (){
								gotoGuideListScreen(context);
							},
						),
						IconButton(
							icon: Icon(Icons.share),
							onPressed: (){
								if ( !Common.isPAU)
									Fluttertoast.showToast(msg: S.of(context).premiumOnly);
								else {
									shareText();
								}
							},
						),
					],
					bottom: TabBar(
						indicatorColor: Colors.white,
						controller: tabController,
						tabs: [
							Tab(
								text: S.of(context).biocontainer_character.toUpperCase(),
							),
							Tab(
								text: S.of(context).challenge_action_bar.toUpperCase(),
							),
							Tab(
								text: S.of(context).timeline_tab.toUpperCase(),
							),
						],
					),
				), //   floatingActionButton: _buildFloatingActionButton(context),
				body: TabBarView(
					controller: tabController,
					children: [
						Center(
							child: SingleChildScrollView(
								child: characterContainer(),
							),
						),
						Center(
							child: Container(
								child: offChallengeContainter(),
							),
						),
						Center(
							child: Container(
								child: timeLineContainer()
							),
						),
					]),
				floatingActionButton: bottomButtons(),
			),
		);


	}

	bottomButtons() {
		switch (tabController.index){
			case 0:
				return FloatingActionButton(
					heroTag: 1,
					shape: StadiumBorder(),
					onPressed: () {
						gotoEditCharacterScreen(context);
					},

					child: Image.asset(ImageConstants.ic_menu_edit));
				break;
			case 1:
				return FloatingActionButton(
					heroTag: 2,
					shape: StadiumBorder(),
					onPressed: (){
						gotoOffChallengeTemplateScreen(context);
					},
					backgroundColor: Common.containerBackColor,
					child: Icon(
						Icons.add,
						size: 20.0,
					),
				);
				break;
			case 2:
				return FloatingActionButton(
					heroTag: 3,
					shape: StadiumBorder(),
					onPressed: (){
						gotoAddTimeLineScreen(context, true);
					},

					child: Icon(
						Icons.add,
						size: 20.0,
					),
				);
				break;
			default:
				return FloatingActionButton(
					heroTag: 4,
					shape: StadiumBorder(),
					onPressed: (){

					},

					child: Image.asset(ImageConstants.ic_menu_edit));
				break;
		}
	}
	
	String description = '';
	Widget characterContainer(){
		setState(() {
			description = generateDescription();
		});
		
		return Container(
			padding: EdgeInsets.all(10),
			child: Column(
				children: <Widget>[
					Row(
						children: <Widget>[
							Padding(
								padding: EdgeInsets.all(10.0),
								child: Column(
									children: <Widget>[ Common.currentCharacter.image == '' ?
										Icon(
											Icons.camera_alt,
											color: Common.containerBackColor,
											size: 50,
										) :
									SizedBox(
										width: 50,
										height: 50,
										child: Utility.imageFromBase64String(Common.currentCharacter.image),
									)
									],
								),
							),
							Padding(
								padding: EdgeInsets.all(10.0),
								child:Column(
									children: <Widget>[
										Text(Common.currentCharacter.name, style: TextStyle(fontSize: 18, color: Common.containerBackColor)),
										Text(Common.currentCharacter.role, style: TextStyle(fontSize: 18, color: Common.containerBackColor))
									],
								),
							)

						],
					),
					Row(
						children: <Widget>[
							Expanded(
								child: SizedBox(
									child: Padding(
										padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5),
										child: Text(description, style: TextStyle(fontSize: 18, color: Common.containerBackColor),),
									),
								),
							)
						],
					)
				],
			),
		);
	}

	offChallengeContainter() {
		if ( offChallenges.isEmpty ) {
			return Center(
				child: Column(
					children: <Widget>[
						Container(
							margin: const EdgeInsets.all(10),
							child: Text(
								S.of(context).biocontainer_challenge_empty,
								style: TextStyle(
									fontSize: 18,
									color: Colors.black,
								),
							),
						)
					],
				),
			);
		} else {
			return Container(
				padding: EdgeInsets.all(8),
				child: ListView.builder(
					itemCount: offChallenges.length,
					scrollDirection: Axis.vertical,
					itemBuilder: (context, index) {
						OffChallenge offchallenge = offChallenges[index];
						List<String> questionLists = getQuestionLists(offchallenge.challengeID);
						return ListTile(
							title: Container(
								padding: EdgeInsets.all(5.0),
								margin: EdgeInsets.only(bottom: 10.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Text(questionLists[0], style: TextStyle(fontSize: 18, color: Common.containerBackColor),),
										Text(questionLists[1],style: TextStyle(fontSize: 14, color: Common.containerBackColor) ),
										SizedBox(height: 15,),
										Text(offchallenge.q1,style: TextStyle(fontSize: 14, color: Common.containerBackColor)),
										SizedBox(height: 15,),
										Text(questionLists[2],style: TextStyle(fontSize: 14, color: Common.containerBackColor)),
										SizedBox(height: 15,),
										Text(offchallenge.q2,style: TextStyle(fontSize: 14, color: Common.containerBackColor)),
										SizedBox(height: 15,),
										Text(questionLists[3],style: TextStyle(fontSize: 14, color: Common.containerBackColor)),
										SizedBox(height: 15,),
										Text(offchallenge.q3,style: TextStyle(fontSize: 14, color: Common.containerBackColor)),
										SizedBox(height: 15,),
										Text(questionLists[4],style: TextStyle(fontSize: 14, color: Common.containerBackColor)),
										SizedBox(height: 15,),
										Text(offchallenge.q4,style: TextStyle(fontSize: 14, color: Common.containerBackColor)),
										SizedBox(height: 15,),
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

	timeLineContainer() {
		if ( timeLines.isEmpty ) {
			return Center(
				child: Column(
					children: <Widget>[
						Container(
							margin: const EdgeInsets.all(10),
							child: Text(
								S.of(context).empty_timeline,
								style: TextStyle(
									fontSize: 18,
									color: Colors.black,
								),
							),
						)
					],
				),
			);
		} else {
			return Container(
				padding: EdgeInsets.all(8),
				child: ListView.builder(
					itemCount: timeLines.length,
					scrollDirection: Axis.vertical,
					itemBuilder: (context, index) {
						Timeline timeLine = timeLines[index];

						return ListTile(
							title: Container(
//								color: MetalTheme.colorPrimaryDark,
								height: 110,
								padding: EdgeInsets.all(5.0),
								margin: EdgeInsets.only(bottom: 10.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Text(timeLine.date + ' ' + timeLine.title + '\n' + timeLine.description, style: TextStyle(color: Colors.white), maxLines: 5,),
									],
								),
								decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(10),
									color: Common.containerBackColor,
									boxShadow: [
										BoxShadow(color: Colors.black, spreadRadius: 1)
									]
								),

							),
							onTap: () {
								Common.currentTimeline = timeLine;
								gotoAddTimeLineScreen(context, false);
							}
						);
					},
				),
			);
		}
	}

	String generateDescription(){
		String name = Common.currentCharacter.name;
		String age = Common.currentCharacter.age;
		String gender = Common.currentCharacter.gender;
		String placeBirth = Common.currentCharacter.placeBirth;
		String job = Common.currentCharacter.profession;
		String height = Common.currentCharacter.height;
		String hairColor = Common.currentCharacter.hairColor;
		String eyeColor = Common.currentCharacter.eyeColor;
		String bodybuild = Common.currentCharacter.bodyBuild;
		String desire = Common.currentCharacter.desire;
		String role = Common.currentCharacter.role;
		String moment = Common.currentCharacter.defmoment;
		String need = Common.currentCharacter.need;
		String phrase = Common.currentCharacter.phrase;
		String trait1 = Common.currentCharacter.trait1;
		String trait2 = Common.currentCharacter.trait2;
		String trait3 = Common.currentCharacter.trait3;
		String note = Common.currentCharacter.note;
		String imageToShow = Common.currentCharacter.image;

		///Setting image
		if ( imageToShow != null && !imageToShow.isEmpty ) {

		} else {
			String defaultPath = "";
		}

		String space = " ";
		StringBuffer bio_txt = new StringBuffer();
		String breakLine = '\n';
		bio_txt.writeAll([name, space, S.of(context).age_bio_1, space, age, space, S.of(context).age_bio_2, breakLine]);
		bio_txt.writeAll([S.of(context).placebirth_bio, space, placeBirth, breakLine]);

		if(job == "Arbeitslos" || job == "Desempleado" || job=="Desempleada" || job=="Unemployed" || job=="Pensiun"){
			bio_txt.writeAll([S.of(context).nojob_bio, job, breakLine]);
		} else {
			bio_txt.writeAll([S.of(context).job_bio, space, job, breakLine]);
		}

		bio_txt.writeAll([S.of(context).height_bio, space, height, breakLine]);
		bio_txt.writeAll([S.of(context).hair_bio_1, space, hairColor, space, S.of(context).hair_bio_2]);
		bio_txt.writeAll([space, S.of(context).eyes_bio, space, eyeColor, breakLine]);
		bio_txt.writeAll([S.of(context).bodybuild_bio, space, bodybuild, breakLine]);

		if (gender=="Masculino" || gender=="Male" || gender=="Pria") {
			bio_txt.writeAll([S.of(context).male_desire_bio ,space ,desire, breakLine]);
			bio_txt.writeAll([S.of(context).male_need_bio, " " , need , "?", breakLine]);
			bio_txt.writeAll([S.of(context).male_moment_bio , " " , moment , breakLine]);
			bio_txt.writeAll([S.of(context).male_trait_bio , " " , trait1 , ", " , trait2 , ", " , trait3 , breakLine, breakLine]);
			bio_txt.writeAll([S.of(context).male_phrase_bio , breakLine, space , phrase , breakLine, breakLine]);
		} else if (gender=="Femenino" || gender=="Female" || gender=="Wanita") {
			bio_txt.writeAll([S.of(context).female_desire_bio , " " , desire , breakLine]);
			bio_txt.writeAll([S.of(context).female_need_bio , " " , need , "?", breakLine]);
			bio_txt.writeAll([S.of(context).female_moment_bio , " " , moment , breakLine]);
			bio_txt.writeAll([S.of(context).female_trait_bio , " " , trait1 , ", " , trait2 , ", " , trait3 , breakLine, breakLine]);
			bio_txt.writeAll([S.of(context).female_phrase_bio , breakLine, space , phrase , breakLine, breakLine]);
		} else {
			bio_txt.writeAll([S.of(context).binary_desire_bio , " " , desire , breakLine]);
			bio_txt.writeAll([S.of(context).binary_need_bio , " " , need , "?", breakLine]);
			bio_txt.writeAll([S.of(context).binary_moment_bio , " " , moment , breakLine]);
			bio_txt.writeAll([S.of(context).binary_trait_bio , " " , trait1 , ", " , trait2 , ", " , trait3 , breakLine, breakLine]);
			bio_txt.writeAll([S.of(context).binary_phrase_bio , breakLine, space , phrase , breakLine, breakLine]);
		}

		bio_txt.writeAll([S.of(context).notes_bio, breakLine, space, note]);
		return bio_txt.toString();
	}

	getQuestionLists(String index){
		List<String> questionLists = [];
		switch ( index ) {
			case 'mentor_challenge':
				questionLists.addAll([Mentor().title,Mentor().q1, Mentor().q2, Mentor().q3, Mentor().q4]);
				return questionLists;
				break;
			case 'sidekick_challenge' :
				questionLists.addAll([ Sidekick().title,Sidekick().q1,Sidekick().q2, Sidekick().q3, Sidekick().q4]);
				return questionLists;
				break;
			case 'antagonist_challenge' :
				questionLists.addAll([Antagonist().title,Antagonist().q1,Antagonist().q2, Antagonist().q3, Antagonist().q4]);
				return questionLists;
				break;
			case 'protagonist_challenge' :
				questionLists.addAll([Protagonist().title, Protagonist().q1,Protagonist().q2, Protagonist().q3, Protagonist().q4]);
				return questionLists;
				break;
			case 'challenge_1' :
				questionLists.addAll([Challenge_1().title, Challenge_1().q1,Challenge_1().q2, Challenge_1().q3, Challenge_1().q4]);
				return questionLists;
				break;
			case 'challenge_2' :
				questionLists.addAll([Challenge_2().title,Challenge_2().q1,Challenge_2().q2, Challenge_2().q3, Challenge_2().q4]);
				return questionLists;
				break;
			case 'challenge_3' :
				questionLists.addAll([Challenge_3().title, Challenge_3().q1,Challenge_3().q2, Challenge_3().q3, Challenge_3().q4]);
				return questionLists;
				break;
			case 'challenge_4' :
				questionLists.addAll([Challenge_4().title, Challenge_4().q1,Challenge_4().q2, Challenge_4().q3, Challenge_4().q4]);
				return questionLists;
				break;
			case 'challenge_5' :
				questionLists.addAll([Challenge_5().title, Challenge_5().q1,Challenge_5().q2, Challenge_5().q3, Challenge_5().q4]);
				return questionLists;
				break;
			case 'challenge_6' :
				questionLists.addAll([Challenge_6().title,Challenge_6().q1,Challenge_6().q2, Challenge_6().q3, Challenge_6().q4]);
				return questionLists;
				break;
			case 'challenge_7' :
				questionLists.addAll([Challenge_7().title, Challenge_7().q1,Challenge_7().q2, Challenge_7().q3, Challenge_7().q4]);
				return questionLists;
				break;
			case 'challenge_8' :
				questionLists.addAll([Challenge_8().title,Challenge_8().q1,Challenge_8().q2, Challenge_8().q3, Challenge_8().q4]);
				return questionLists;
				break;
			case 'challenge_9' :
				questionLists.addAll([Challenge_9().title,Challenge_9().q1,Challenge_9().q2, Challenge_9().q3, Challenge_9().q4]);
				return questionLists;
				break;
			case 'challenge_10' :
				questionLists.addAll([Challenge_10().title,Challenge_10().q1,Challenge_10().q2, Challenge_10().q3, Challenge_10().q4]);
				return questionLists;
				break;
		}

	}
	
	Future<void> share(String text) async {
		await FlutterShare.share(
			title: 'Share Post',
			text: text,
			linkUrl: 'https://plotgen.page.link',
			chooserTitle: 'Please choose'
		);
	}
	
	shareText() {
		switch (tabController.index) {
			case 0:
				share(description);
				break;
			case 1:
				if (offChallenges == null || offChallenges.length == 0 )
					Fluttertoast.showToast(msg: 'No Challenge');
				else {
					StringBuffer tmp = new StringBuffer();
					for (OffChallenge one in offChallenges) {
						List<String> questionLists = getQuestionLists(one.challengeID);
						tmp.writeln(description);
						tmp.writeln(questionLists[0]);
						tmp.writeln(questionLists[1]);
						tmp.writeln(one.q1);
						tmp.writeln(questionLists[2]);
						tmp.writeln(one.q2);
						tmp.writeln(questionLists[3]);
						tmp.writeln(one.q3);
						tmp.writeln(questionLists[4]);
						tmp.writeln(one.q4);
					}
					share(tmp.toString());
				}
				break;
			case 2:
				break;
		}
	}
}
