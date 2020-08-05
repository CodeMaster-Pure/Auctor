import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/sharedPreferenceManager.dart';
import 'package:plotgenerator/engine/utility.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/model/Character.dart';
import 'package:plotgenerator/ui/screen/addCharacterScreen.dart';
import 'package:plotgenerator/ui/screen/offCharacterDetailScreen.dart';
import 'package:plotgenerator/ui/screen/outlineListScreen.dart';
import 'package:plotgenerator/ui/screen/writeStoryScreen.dart';
import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class CharacterListScreen extends StatefulWidget {
	CharacterListScreen({Key key, this.onPressed, this.tooltip, this.icon}) : super(key: key);

	final Function() onPressed;
	final String tooltip;
	final IconData icon;

	@override
	CharacterListScreenState createState() => CharacterListScreenState();
}

class CharacterListScreenState extends State<CharacterListScreen>  with SingleTickerProviderStateMixin {
	CharacterListScreenState();

	List<Character> characters = [];
	String writeBtnString;
	bool _visible = true;
	bool isOpened = false;
	AnimationController _animationController;
	Animation<double> _animateIcon;
	Animation<double> _translateButton;
	Curve _curve = Curves.easeOut;
	double _fabHeight = 56.0;

	@override
	void initState() {
//		for (int i = 0; i < 100; i++){
//			challengeDoneList.add(0);
//		}

		_animationController =
		AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
			..addListener(() {
				setState(() {});
			});
		_animateIcon =
			Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

		_translateButton = Tween<double>(
			begin: _fabHeight,
			end: -14.0,
		).animate(CurvedAnimation(
			parent: _animationController,
			curve: Interval(
				0.0,
				0.75,
				curve: _curve,
			),
		));

		super.initState();


		Future.delayed(Duration.zero, this.checkTutorial);
		Future.delayed(Duration.zero, this.loadCharacters);

		writeBtnString = '';
		SharedPreferenceManager.getSharePref('offlineStory_create_mode', 0).then((value){
			setState(() {
				if (value == 0)
					writeBtnString = S.of(context).write_story;
				else
					writeBtnString = S.of(context).edit_story;
			});

		});
	}

	checkTutorial() {
		TutorialManager.check(context);
	}

	@override
	void dispose() {
		_animationController.dispose();
		super.dispose();
	}

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) {
		if(state == AppLifecycleState.resumed){

		}
	}

	animate() {
		setState(() {
		  _visible = !_visible;
		});
		if (!isOpened) {
			_animationController.forward();
			custom = new Icon(Icons.close);

		} else {
			_animationController.reverse();
			custom = new Icon(Icons.add);
		}
		isOpened = !isOpened;
	}

//	List<int> challengeDoneList = [];
	loadCharacters() {
		DatabaseHelper().getCharacterByProjectID(Common.currentProject.id.toString()).then((results) {
			setState(() {
				characters = results;
//				for ( int i =0; i< characters.length; i++) {
//					String challengeString = characters[i].challengesDone;
//					List<String> splitString = challengeString.split('***');
//					if (splitString != null ) {
//						int count = (splitString.length - 1);
//						int challengeDone = 10 * count;
//						challengeDoneList[i] = challengeDone;
//					}
//				}
				Common.currentCharacterLists = results;
			});
		});
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

	gotoOffCharacterDetailScreen(BuildContext context){
		Navigator.push(context, MaterialPageRoute(builder: (context) => OffCharacterDetailScreen()));
	}

	gotoAddCharacterScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => AddCharacterScreen()));
	}

	gotoOutlineListScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => OutlineListScreen()));
	}

	gotoWriteStoryScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => WriteStoryScreen()));
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
				title: Text(Common.currentProject.name),
				actions: <Widget>[

				],
			),
			body: (characters == null || characters.length <= 0)
				? noCharacterContainer(context)
				: characterListView(context),
			floatingActionButton: customFloatingButton()

		);
	}

	noCharacterContainer(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Container(
						margin: const EdgeInsets.only(left: 16, right: 16),
						child: Text(
							S.of(context).character_empty_text,
							textAlign: TextAlign.center,
							style: TextStyle(
								fontSize: 25,
								color: Colors.black,
							),
						),
					)
				],
			),
		);
	}

	characterListView(BuildContext context) {

		return Container(
			padding: EdgeInsets.all(8),
			child: ListView.separated(
				itemCount: characters.length,
				itemBuilder: (context, index) {
					Character character = characters[index];
					String challengeDone = '0';
					
					int intChallengeDone = character.challengesDone;
					intChallengeDone = intChallengeDone * 10;
					challengeDone = intChallengeDone.toString();
					
					
					var width = MediaQuery.of(context).size.width;
					return Container(
						color: Common.containerBackColor,
						child: FlatButton(
							child: Padding(
								padding: EdgeInsets.all(10.0),
								child: Row(
									children: <Widget>[
										SizedBox(
											width: width * 0.2,
//											height: 40,
											child: character.image == '' ? Icon(
												Icons.camera_alt,
												size: 40,
												color: Common.currentTheme != 5 ? Colors.black : Colors.white
											) : CircleAvatar(
												radius: 25.0,child: Utility.imageFromBase64String(character.image) ,
												backgroundColor: Colors.transparent,
											)
										),
										SizedBox(
											width: width * 0.4,
//											height: 40,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
//											mainAxisAlignment: MainAxisAlignment.start,
												children: <Widget>[
													Text(character.name, style: TextStyle(color: Common.currentTheme != 5 ? Colors.black : Colors.white),),
													Text(character.role ?? 'Protagonist', style: TextStyle(color: Common.currentTheme != 5 ? Colors.black : Colors.white),),
												],
											),
										),
										SizedBox(
											width: width * 0.2,
//											height: 40,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.end,
//											mainAxisAlignment: MainAxisAlignment.end,
												children: <Widget>[
													Text( challengeDone + '%', style: TextStyle(color: Common.currentTheme != 5 ? Colors.black : Colors.white),),
													Text('Challenges', style: TextStyle(color: Common.currentTheme != 5 ? Colors.black : Colors.white),)
												],
											),
										)
									],
								),
							),
							padding: EdgeInsets.all(0.0),
							onPressed: () {
								Common.currentCharacter = character;
								gotoOffCharacterDetailScreen(context);
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

	Widget writeStoryBtn() {
		return Container(
			child: FloatingActionButton.extended(
				heroTag: 1,
				onPressed: (){
					gotoWriteStoryScreen(context);
				},

				label: Text(writeBtnString),
				icon: SvgPicture.asset(ImageConstants.ic_book_black, color: Common.currentTheme != 5 ? Colors.black : Colors.white),

			),
		);
	}

	Widget outLineBtn() {
		return Container(
			child: FloatingActionButton.extended(
				heroTag: 2,
				onPressed: (){
					gotoOutlineListScreen(context);
				},
				label: Text(S.of(context).add_outline),
				icon: SvgPicture.asset(ImageConstants.ic_book_black, color: Common.currentTheme != 5 ? Colors.black : Colors.white),
			),
		);
	}

	Widget addCharacterBtn() {
		return Container(
			child: FloatingActionButton.extended(
				heroTag: 3,
				onPressed: (){
					gotoAddCharacterScreen(context);
				},

				label: Text(S.of(context).add_char),
				icon: SvgPicture.asset(ImageConstants.ic_character_black, color: Common.currentTheme != 5 ? Colors.black : Colors.white),
			),
		);
	}

	Icon custom = new Icon(Icons.add);
	Widget toggle() {
		return Container(
			child: FloatingActionButton(
				heroTag: 4,

				onPressed: animate,
				tooltip: 'Toggle',
				child: custom
//				AnimatedIcon(
//					icon: AnimatedIcons.add_event,
//					progress: _animateIcon,
//				),
			),
		);
	}

	Widget customFloatingButton() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.end,
			mainAxisAlignment: MainAxisAlignment.end,
			children: <Widget>[
				AnimatedOpacity(
					child: Transform(
						transform: Matrix4.translationValues(
							0.0,
							_translateButton.value * 3.0,
							0.0,
						),
						child: outLineBtn(),
					),
					opacity: !_visible ? 1.0 :0.0,
					duration: Duration(microseconds: 1000),
				),
				AnimatedOpacity(
					child: Transform(
						transform: Matrix4.translationValues(
							0.0,
							_translateButton.value * 2.0,
							0.0,
						),
						child: writeStoryBtn(),
					),
					opacity: !_visible ? 1.0 :0.0,
					duration: Duration(microseconds: 1000),
				),
				AnimatedOpacity(
					child: Transform(
						transform: Matrix4.translationValues(
							0.0,
							_translateButton.value,
							0.0,
						),
						child: addCharacterBtn(),
					),
					opacity: !_visible ? 1.0 :0.0,
					duration: Duration(microseconds: 1000),
				),
				toggle(),
			],
		);
	}
}
