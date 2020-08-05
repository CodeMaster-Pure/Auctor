import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/model/prompt.dart';
import 'package:plotgenerator/model/user.dart';
import 'package:plotgenerator/ui/screen/challengeScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';

import '../../engine/colors.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class AddPromptScreen extends StatefulWidget {

	@override
	AddPromptScreenState createState() => AddPromptScreenState();
}

class AddPromptScreenState extends State<AddPromptScreen> {

	bool _validate = false;
	String errorText = 'Required';
	final promptController = TextEditingController();

	@override
	void initState() {
		super.initState();
	}

	@override
	void dispose() {
		super.dispose();
	}

	@override
	void didChangeAppLifecycleState(AppLifecycleState state) {

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
				title: Text('Submit Your Prompt'),
			),
			body: Container(
				padding: EdgeInsets.all(10.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						SizedBox(
							height: 50,
						),
						Text('Send your prompt now!', style: TextStyle(fontFamily: 'roboto_bold', fontSize: 20),),
						SizedBox(
							height: 20,
						),
						TextField(
							decoration: InputDecoration(
								errorText: _validate ? errorText : null,
								errorStyle: TextStyle(
									color: Colors.red
								),
								hintText: 'Write your prompt here'
							),
							style: TextStyle(fontSize: 14, fontFamily: 'roboto_light'),
//							cursorColor: Colors.black,
							onChanged: (value) {},
							controller: promptController,
							maxLines: 10,
						),
						SizedBox(
							height: 20,
						),
						Text(S.of(context).triggers_submit_disclaimer, style: TextStyle(color: ColorConstants.color_trigger_1, fontSize: 12),),
						Expanded(
							child: SizedBox(),
						),
						SizedBox(
							width: MediaQuery.of(context).size.width,
							height: 50,
							child: RaisedButton(
								color: Common.containerBackColor,
								child: Text(S.of(context).submit_button.toUpperCase(), style: TextStyle(color: Colors.white),),
								onPressed: (){
									onSubmit(context);
								},
							),
						)

					],
					mainAxisAlignment: MainAxisAlignment.start,
				),
			)
		);
	}

	onSubmit(BuildContext context){
		setState(() {
			if ( promptController.text.isEmpty) {
				errorText = 'Required';
				_validate = true;
				return;
		  	}
			else if (promptController.text.length > 120 ) {
				errorText = promptController.text.length.toString() + '/120. Please use less than 120 characters';
				_validate = true;
				return;
			} else {
				save();
			}
		});
	}

	Future<bool> save() async {
		String dbname;
		if (Common.currentLanguageEnglish)
			dbname = 'triggers';
		else
			dbname = 'triggers_es';
		
		if (Common.currentUser != null ) {
			String id = Firestore.instance
				.collection(dbname)
				.document()
				.documentID;
			print("Soppy trigger id : " + id);
			int date = (DateTime.now().millisecondsSinceEpoch / 1000).round();

			Prompt prompt = new Prompt(
				id: id,
				date: date,
				selected: false,
				story: promptController.text,
				user: new User(
					uid: Common.currentUser.uid,
					name: Common.currentUser.name,
					email: Common.currentUser.email,
					uriString: Common.currentUser.uriString).toMap()
			);

			try {
				Firestore.instance.document( dbname + '/0/special/$id').setData(prompt.toMap()).then((result){
					Fluttertoast.showToast(msg: 'Prompt Added');
					print('Soppy: Prompt added');
					gotoPromptsScreen(context);
				});
			}  catch (e) {
				// throw the Firebase AuthException that we caught
				throw new Exception(e.toString());
			}
		} else {
			Fluttertoast.showToast(msg: 'Please login in Profile Section');
			return false;
		}
	}

}