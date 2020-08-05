import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/model/Outline.dart';
import 'package:plotgenerator/ui/screen/outlineListScreen.dart';

import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class AddOutlineScreen extends StatefulWidget {
	AddOutlineScreen({Key key, this.check}) : super(key: key);
	final bool check;

	@override
	AddOutlineScreenState createState() => AddOutlineScreenState(check: check);
}

class AddOutlineScreenState extends State<AddOutlineScreen> {

	AddOutlineScreenState({this.check});
	final bool check;

	final titleController = TextEditingController();
	final descriptionController = TextEditingController();
	final characterController = new TextEditingController();

	List<bool> characterCheckValuelist = [];

	@override
	void initState() {
		super.initState();
		for(int i = 0; i < Common.currentCharacterLists.length; i++) {
			characterCheckValuelist.add(false);
		}
		if (!check) {
			titleController.text = Common.currentOutline.name;
			descriptionController.text = Common.currentOutline.description;

			List<String> splitStr = Common.currentOutline.characterPresent.split(',');
			for (String tmp in splitStr ){
				if (tmp == '')
					continue;
				int index = int.parse(tmp);
				characterCheckValuelist[index - 1] = true;
			}
		}
	}

	@override
	void dispose() {
		titleController.dispose();
		descriptionController.dispose();
		super.dispose();
	}

	onSave(BuildContext context) {
		if (titleController.text == "") { Helper.showErrorToast(S.of(context).prompt_outline); return; }

		String presentCharacters = '';
		if (characterCheckValuelist != null && characterCheckValuelist.length != 0) {
			for (int i = 0; i < characterCheckValuelist.length; i++) {
				if (characterCheckValuelist[i])
					presentCharacters = presentCharacters + ',' + Common.currentCharacterLists[i].id.toString();
			}
		}

		print(presentCharacters);

		Outline outline;
		if (check) {
			outline = new Outline(
				name: titleController.text,
				description: descriptionController.text,
				project_id: Common.currentProject.id.toString(),
				position: '0',
				characterPresent: presentCharacters
			);

			DatabaseHelper().createOutline(outline).then((result){
				if (result == 1)
					Fluttertoast.showToast(msg: 'Saved Outline.');
				else
					Fluttertoast.showToast(msg: 'Failed Save!.');
				Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
			});
		} else {
			outline = new Outline(
				id: Common.currentOutline.id,
				name: titleController.text,
				description: descriptionController.text,
				project_id: Common.currentProject.id.toString(),
				position: '0',
				characterPresent: presentCharacters
			);

			DatabaseHelper().updateOutline(outline).then((result){
				if (result == 1)
					Fluttertoast.showToast(msg: 'Updated Outline.');
				else
					Fluttertoast.showToast(msg: 'Failed update!');
				Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
			});


		}

	}

	onDelete(BuildContext context){
		if (check)
			return null;
		else {
			DatabaseHelper().deleteOutlineByid(Common.currentOutline.id).then((result){
				if (result == 1)
					Fluttertoast.showToast(msg: 'Deleted');
				else
					Fluttertoast.showToast(msg: 'Failed');

				Navigator.push(context, MaterialPageRoute(builder: (context) => OutlineListScreen()));
			});
		}
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
			),
			body: SingleChildScrollView(
				child: ConstrainedBox(
					constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							outlineContainer()
						],
					),
				),
			),
			floatingActionButton: customFloatingActionButtons()
		);
	}

	customFloatingActionButtons() {
		if (check){
			return FloatingActionButton(
				heroTag: 1,
				child: Icon(Icons.save),
				onPressed: () => onSave(context),
			);
		} else {
			return Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: [
					FloatingActionButton(
						heroTag: 2,
						child: Icon(Icons.delete),
						onPressed: () => onDelete(context),
					),
					SizedBox(
						width: 10,
					),
					FloatingActionButton(
						heroTag: 1,
						child: Icon(Icons.save),
						onPressed: () => onSave(context),
					),
				],
			);
		}
	}

	Widget outlineContainer() {
		return Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					SizedBox(
						height: 20,
					),
					Text(
						'Title',
						style: TextStyle(fontSize: 18, ),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						style: TextStyle(color: Common.containerBackColor, fontSize: 18),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: titleController,
						maxLines: 1,
					),
					SizedBox(
						height: 20,
					),
					Text(
						'Description',
						style: TextStyle(fontSize: 18, ),
					),
					TextField(
						style: TextStyle(color: Common.containerBackColor, fontSize: 18),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: descriptionController,
						maxLines: 10,
					),
					SizedBox(
						height: 20,
					),
					Text(
						'Characters',
						style: TextStyle(fontSize: 18, ),
					),
					chractersContainer(),
				],
			),
		);
	}


	chractersContainer(){
		if (characterCheckValuelist.isEmpty || characterCheckValuelist.length == 0 || characterCheckValuelist == null )
			return Container();
		else {
			return Container(
				child: Column(
					children: List.generate(Common.currentCharacterLists.length, (index) {
						return CheckboxListTile(
							activeColor: Common.containerBackColor,
							title: Text(Common.currentCharacterLists[index].name),
							value: characterCheckValuelist[index],
							onChanged: (newValue) {
								setState(() {
									characterCheckValuelist[index] = !characterCheckValuelist[index];
								});
							},
							controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
						);
					})
				),
			);
		}
	}
}
