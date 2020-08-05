import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/sharedPreferenceManager.dart';
import 'package:plotgenerator/engine/utility.dart';
import 'package:plotgenerator/ui/screen/addProjectScreen.dart';
import 'package:plotgenerator/ui/screen/challengeScreen.dart';
import 'package:plotgenerator/ui/screen/discoverScreen.dart';
import 'package:plotgenerator/ui/screen/editProjectScreen.dart';
import 'package:plotgenerator/ui/screen/premiumScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';
import 'package:plotgenerator/ui/screen/characterListScreen.dart';
import 'package:plotgenerator/ui/screen/promptsScreen.dart';
import 'model/Project.dart';
import 'engine/database/databaseHelper.dart';
import 'engine/resource.dart';
import 'engine/tutorialManager.dart';
import 'generated/i18n.dart';
import 'model/user.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	SharedPreferenceManager.getSharePref('current_theme', 1).then((result) {
		runApp(MyApp(theme: result));
	});
}

class MyApp extends StatelessWidget {
	int theme;
	MyApp({this.theme});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			localizationsDelegates: [S.delegate],
			supportedLocales: S.delegate.supportedLocales,
			title: 'Auctor',
			theme: ThemeConstants.currentTheme(context, theme),
			home: MainScreen(title: 'Home'),
		);
	}
}

class MainScreen extends StatefulWidget {
	MainScreen({Key key, this.title}) : super(key: key);
	final String title;

	@override
	MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {

	MainScreenState();
	DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
	static bool calledAlready = false;
	FirebaseUser mUser;
	Firestore mDatabase;
	CollectionReference mUserDatabase;
	String firebase_token;
	FirebaseAuth mAuth;
	bool firstTime;
	List<Project> projects = [];
	List<int> counts = [];
	int riddle;
	bool isEnglish = true;
	

	@override
	void initState() {
		super.initState();

		counts = [];
		WidgetsBinding.instance.addObserver(this);
		
		checkDeviceType();
		Future.delayed(Duration.zero, this.loadProjects);
		Common.isPAU = false;
		FirebaseAuth.instance.currentUser().then((result){
			mUser = result;
			Common.currentUser = new User(uid: result.uid, name: result.displayName, email: result.email, uriString: result.photoUrl);
			Common.currentFirebaseUser = mUser;
			String email = mUser.email;
			getPremium(email);
		});

		SharedPreferenceManager.getSharePref('current_theme', 1).then((value){
			Utility.updateUI(value);
		});
		
		Future.delayed(Duration.zero, this.checkDeviceLanguage).then((value){
			if ( value == 'es' ) {
				Common.currentLanguageEnglish = false;
			}
			else {
				Common.currentLanguageEnglish = true;
			}
		});
	}

	@override
	void deactivate(){
		super.deactivate();
	}

	@override
	void dispose() {
		WidgetsBinding.instance.removeObserver(this);
		super.dispose();
	}

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) {
		if(state == AppLifecycleState.resumed){
			counts = [];
			loadProjects();
		} else if(state == AppLifecycleState.inactive) {
		} else if(state == AppLifecycleState.detached) {
		}
	}
	
	getPremium( String email) async {
		await Firestore.instance.document('premium_users/' + email).get().then((result){
			if (result.data['premium']) {
				Common.isPAU = true;
			} else
				Common.isPAU = false;
		});
	}

	checkTutorial() {
		TutorialManager.check(context);
	}
	
	checkDeviceType() async {
		AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo.catchError((onError) => null);
		IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo.catchError((onError) => null);
		
		if(androidDeviceInfo != null) {
			Common.currentDeviceType = 'Android';
		} else if (iosDeviceInfo != null){
			Common.currentDeviceType = 'iPhone';
		}
	}

	loadProjects() {
		DatabaseHelper().allProjects.then((results) {
			setState(() {
				projects = results;
			});
			for ( Project project in projects) {
				DatabaseHelper().countCharacterByProjectID(project.id).then((result){
					setState(() {
						counts.add(result);
					});
				});
			}
			Common.projectCount = results.length;
			if ( projects.length == 0 ) {
				Common.onBoarding = 1;
				Common.tutorialMODE = true;
				Future.delayed(Duration.zero, this.checkTutorial);
			}
		});

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

	gotoProjetDetail(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterListScreen()));
	}

	gotoAddProject(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => AddProjectScreen()));
	}

	gotoEditProjectScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => EditProjectScreen()));
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
				title: Text(S.of(context).projects_tab),
			),
			body: (projects == null || projects.length <= 0)
				? noProjectsContainer(context)
				: projectListView(context),
			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.add),
				onPressed: () {
					gotoAddProject(context);
				},
			), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
	
	noProjectsContainer(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Container(
						margin: const EdgeInsets.only(left: 10, right: 10),
						child: Text(
							S.of(context).projects_empty_text,
							textAlign: TextAlign.center,
							style: TextStyle(fontSize: 25, color: Colors.black),
						),
					)
				],
			),
		);
	}

	projectListView(BuildContext context) {
		return Container(
			padding: EdgeInsets.all(8),
			child: ListView.builder(
				itemCount: projects.length,
				scrollDirection: Axis.vertical,
//				itemExtent: 260.0,
				itemBuilder: (context, index) {
					Project project = projects[index];
					var width = MediaQuery.of(context).size.width;
					String characterCount = '0';
					if (counts.length <= index ){
						characterCount = '0';
					} else {
						characterCount = counts[index].toString();
					}

					return ListTile(
						title: Container(
						color: Common.containerBackColor,
							child: Column(
								children: <Widget>[
									SizedBox(
										height: 200,
										child: Stack(
											children: <Widget>[
												SizedBox(
													width: width,
													child: project.image == '' ?
													Container(child: Image.asset(ImageConstants.ic_menu_camera)) : Utility.imageFromBase64String(project.image)
												),
												Positioned(
													child: OutlineButton(
														child: Text('Edit', style: TextStyle(color: Colors.white),),
														onPressed: (){
															Common.currentProject = project;
															gotoEditProjectScreen(context);
														},
														shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
														borderSide: BorderSide(color: Colors.white),
													),
													right: 10,
													top: 10,
												),

											],
										)
									),
									Container(
										padding: EdgeInsets.all(10.0),
										child: Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											crossAxisAlignment: CrossAxisAlignment.center,
											children: <Widget>[
												Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: <Widget>[
														Text(project.name, style: TextStyle(color: Colors.white),),
														Text(project.genre, style: TextStyle(color: Colors.white)),
													],
												),
												Column(
													crossAxisAlignment: CrossAxisAlignment.end,
//											mainAxisAlignment: MainAxisAlignment.end,
													children: <Widget>[
														Text(characterCount, style: TextStyle(color: Colors.white)),
														Text(S.of(context).character_list_tab, style: TextStyle(color: Colors.white))
													],
												),
											],
										),
									)
								],
							),
						),
						onTap: () {
							Common.currentProject = project;
							gotoProjetDetail(context);
						}
						);
					},
			),
		);
	}
	
	checkDeviceLanguage(){
		Locale myLocale = Localizations.localeOf(context);
		print('language code: ' + myLocale.languageCode);
		print('country code:' + myLocale.countryCode);
		return myLocale.countryCode;
	}
}