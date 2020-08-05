import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/sharedPreferenceManager.dart';
import 'package:plotgenerator/engine/utility.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/model/user.dart';

import '../../engine/colors.dart';
import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'addProjectScreen.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class ProfileScreen extends StatefulWidget {
	@override
	ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
	final emailController = TextEditingController();
	final nameController = TextEditingController();
	final projectCreatedController = TextEditingController();
	final characterCreatedController = TextEditingController();

	List<String> themeLists = ['Light Theme', 'Metal Theme', 'Dark Theme', 'Romance Theme', 'Autumn Theme', 'Black & White Theme'];
	String theme;
	bool b_notification = true;
	String imagepath;
	FirebaseUser mUser;


	@override
	void initState() {
		super.initState();

		if (Common.currentUser != null ) {
			setProfileInformation();
		}
	}

	@override
	void dispose() {
		super.dispose();
		emailController.dispose();
		nameController.dispose();
		projectCreatedController.dispose();
		characterCreatedController.dispose();

	}

	setProfileInformation(){
		emailController.text = Common.currentUser.email;
		nameController.text = Common.currentUser.name;
		projectCreatedController.text = Common.projectCount.toString();

		imagepath = Common.currentUser.uriString;
		SharedPreferenceManager.getStringSharePref('notifications').then((result){
			if (result == 'true')
				b_notification = true;
			else
				b_notification = false;
		});

		Future.delayed(Duration.zero, this.countCharacters);
		SharedPreferenceManager.getSharePref('current_theme', 1).then((result) {
			switch (result) {
				case 0:
					setState(() {
					  theme = themeLists[0];
					});
					break;
				case 1:
					setState(() {
						theme = themeLists[1];
					});
					break;
				case 2:
					setState(() {
						theme = themeLists[2];
					});
					break;
				case 3:
					setState(() {
						theme = themeLists[3];
					});
					break;
				case 4:
					setState(() {
						theme = themeLists[4];
					});
					break;
				case 5:
					setState(() {
						theme = themeLists[5];
					});
					break;
				default:
					setState(() {
						theme = themeLists[1];
					});
					break;
			}
		});
	}

	countCharacters() {
		DatabaseHelper().countAllCharacters().then((results) {
			setState(() {
				characterCreatedController.text = results.toString();
			});
		});
	}


	GoogleSignIn _googleSignIn = GoogleSignIn();
	login() {
		_handleSignIn().then((FirebaseUser user) {
			if (user != null)
				setState(() {
					setProfileInformation();
				});
		}).catchError((e) {
			Helper.showErrorToast(e.toString());
		});
	}

	Future<void> _signout() async {
		await FirebaseAuth.instance.signOut().then((result){
			Fluttertoast.showToast(msg: 'Sign Out Success.');
			setState(() {
				Common.currentFirebaseUser = null;
			});
		});
	}

	Future<FirebaseUser> _handleSignIn() async {
		final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
		final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

		final AuthCredential credential = GoogleAuthProvider.getCredential(
			accessToken: googleAuth.accessToken,
			idToken: googleAuth.idToken,
		);

		mUser = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
		Common.currentFirebaseUser = mUser;
		Common.currentUser = new User ( uid: mUser.uid, name: mUser.displayName, email: mUser.email, uriString: mUser.photoUrl );
		return mUser;
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
									""
								),
								decoration: BoxDecoration(color: Common.containerBackColor)),
						),
						ListTile(
							leading: SvgPicture.asset(ImageConstants.SideMenuWorkshop, color: Common.containerBackColor),
							title: Text(S.of(context).story_tab),
							onTap: () => { gotoMainScreen(context)},
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
				title: Text(S.of(context).my_profile),
			),
			body: (Common.currentFirebaseUser == null) ?
				signinGoogleContainer(context)
				: profileContainer(context)
		);
	}

	signinGoogleContainer(BuildContext context) {
		return Container(
			color: Colors.white,
			child: Center(
				child: Column(
					mainAxisSize: MainAxisSize.max,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(S.of(context).must_login),
						SizedBox(height: 10),
						_signInButton(),
					],
				),
			),
		);
	}

	profileContainer(BuildContext context){
		return Container(
			child: SingleChildScrollView(
				child: ConstrainedBox(
					constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Container(
								padding: EdgeInsets.all(10),
								width: 150,
								height: 150,
								child: imagepath == null
									? Icon(
									Icons.photo_camera,
									color: Common.containerBackColor,
									size: 150)
									: CircleAvatar(
									radius: 50.0,
									backgroundImage: NetworkImage(imagepath),
									backgroundColor: Colors.transparent,
								),
							),
							infoContainer(context),
						],
					),
				),
			),
		);
	}

	infoContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						S.of(context).info,
						style: TextStyle(fontSize: 18, fontFamily: 'typewcond_bold'),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						enabled: false,
						decoration: InputDecoration(
							labelText: S.of(context).email,
						),
						style: TextStyle( fontSize: 14, fontFamily: 'typewcond_regular'),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: emailController,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						enabled: false,
						decoration: InputDecoration(
							labelText: S.of(context).name,
						),
						style: TextStyle( fontSize: 14, fontFamily: 'typewcond_regular'),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: nameController,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					themeDropdown(context),
					SizedBox(
						height: 10,
					),
					TextField(
						enabled: false,
						decoration: InputDecoration(
							labelText: S.of(context).projects_created,
						),
						style: TextStyle(fontSize: 14, fontFamily: 'typewcond_regular'),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: projectCreatedController,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						enabled: false,
						decoration: InputDecoration(
							labelText: S.of(context).character_create,
						),
						style: TextStyle( fontSize: 14, fontFamily: 'typewcond_regular'),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: characterCreatedController,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text('Notifications', style: TextStyle(fontFamily: 'typewcond_regular', fontSize: 14),),
							Checkbox(
								value: b_notification,
								onChanged: _onRememberMeChanged
							)
						],
					),

					SizedBox(
						height: 10,
					),
					Common.isPAU == true ? SizedBox(height: 10,) :
					FlatButton(
						child: Text('50% OFF PREMIUM!', style: TextStyle(fontFamily: 'typewcond_regular'),),
						color: ColorConstants.colorAccent,
						onPressed: (){

						},
					),
					FlatButton(
						child: Text(S.of(context).sign_out.toUpperCase(), style: TextStyle(fontFamily: 'typewcond_regular')),
						color: ColorConstants.colorPrimary,
						onPressed: (){
							_signout();
						},
					),
				],
			),
		));
	}

	void _onRememberMeChanged(bool newValue) => setState(() {
		b_notification = newValue;

		if (b_notification) {
			// TODO: Here goes your functionality that remembers the user.
		} else {
			// TODO: Forget the user
		}
	});

	Widget _signInButton() {
		return OutlineButton(
			splashColor: Colors.grey,
			onPressed: () { login(); },
//			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
			highlightElevation: 0,
			borderSide: BorderSide(color: Colors.grey),
			child: Padding(
				padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
				child: Row(
					mainAxisSize: MainAxisSize.min,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
						Padding(
							padding: const EdgeInsets.only(left: 10),
							child: Text(
								'Sign in',
								style: TextStyle(
									fontSize: 20,
									color: Colors.grey,
								),
							),
						)
					],
				),
			),
		);
	}



	themeDropdown(BuildContext context) {
		return (Container(
			width: 200,
			child: DropdownButton<String>(
				value: theme,
				icon: Icon(Icons.arrow_drop_down),
				iconSize: 24,
				style: TextStyle(fontSize: 14, color: Common.containerBackColor, fontFamily: 'typewcond_regular'),
				isExpanded: true,
				onChanged: (String data) {
					if (checkIAP(data)) {
						setState(() {
							theme = data;
						});
					}
				},
				items: themeLists.map((e) {
					return DropdownMenuItem(
						value: e,
						child: Text(e),
					);
				}).toList()),
		));
	}



	bool checkIAP(String theme){
		bool isIAP = Common.isPAU;
		switch (theme) {
			case 'Light Theme':
				Common.currentTheme = 0;
				SharedPreferenceManager.saveOnSharePregInt('current_theme', 0);
				Utility.updateUI(0);

				break;
			case 'Metal Theme':
				Common.currentTheme = 1;
				SharedPreferenceManager.saveOnSharePregInt('current_theme', 1);
				Utility.updateUI(1);

				break;
			case 'Dark Theme':
				if (!isIAP) {
					Fluttertoast.showToast(msg: S.of(context).themes_disclaimer);
					return false;
				}
				Common.currentTheme = 2;
				SharedPreferenceManager.saveOnSharePregInt('current_theme', 2);
				Utility.updateUI(2);

				break;
			case 'Romance Theme':
				if (!isIAP) {
					Fluttertoast.showToast(msg: S.of(context).themes_disclaimer);
					return false;
				}
				Common.currentTheme = 3;
				SharedPreferenceManager.saveOnSharePregInt('current_theme', 3);
				Utility.updateUI(3);

				break;
			case 'Autumn Theme':
				if (!isIAP) {
					Fluttertoast.showToast(msg: S.of(context).themes_disclaimer);
					return false;
				}
				Common.currentTheme = 4;
				SharedPreferenceManager.saveOnSharePregInt('current_theme', 4);
				Utility.updateUI(4);

				break;
			case 'Black & White Theme':
				Common.currentTheme = 5;
				SharedPreferenceManager.saveOnSharePregInt('current_theme', 5);
				Utility.updateUI(5);

				break;
		}
		return true;
	}



}