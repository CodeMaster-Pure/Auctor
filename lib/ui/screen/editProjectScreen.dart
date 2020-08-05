import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/model/Project.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/imagePicker.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/utility.dart';
import 'package:plotgenerator/generated/i18n.dart';

import '../../engine/colors.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class EditProjectScreen extends StatefulWidget {
	EditProjectScreen({Key key}) : super(key: key);

	@override
	EditProjectScreenState createState() => EditProjectScreenState();
}

class EditProjectScreenState extends State<EditProjectScreen> {
	final nameController = TextEditingController();
	final summaryController = TextEditingController();

	EditProjectScreenState();

	String genre = "";
	String summary = "";
	String imgString = '';
	bool isEdit = false;

	@override
	void initState() {
		super.initState();
		nameController.text = Common.currentProject.name;
		summaryController.text = Common.currentProject.plot;
		genre = Common.currentProject.genre;
		imgString = Common.currentProject.image;
	}

	@override
	void dispose() {
		nameController.dispose();
		summaryController.dispose();
		super.dispose();
	}

	onPhoto(BuildContext context) {
		CustomImagePicker.show(context, (imageFile) {
			setState(() {
				if (imageFile == null)
					this.imgString = '';
				else
					this.imgString = Utility.base64String(imageFile.readAsBytesSync());
			});
		});
	}

	onDelete() {
		DatabaseHelper().deleteProjectFromSQL(Common.currentProject.id).then((result){
			if (result == 1)
				Fluttertoast.showToast(msg: 'Deleted project');
			else
				Fluttertoast.showToast(msg: 'Sorry, Failed operation. Try again.');
		});
		Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
	}

	onUpdate(BuildContext context) {
		if (nameController.text == "") { Helper.showErrorToast(S.of(context).projects_empty); return; }
		print('soppy genre is:' + genre);

		Project project = Project(id: Common.currentProject.id, name: nameController.text, genre: genre, plot: summaryController.text, image: imgString);
		DatabaseHelper().updateProject(project).then((result){
			Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
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
								child: SvgPicture.asset(ImageConstants.SideMenuPrompts, color: ColorConstants.colorPrimaryDark),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).trigger_tab),
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
				title: Text(S.of(context).projects_tab),
			),
			body: SingleChildScrollView(
				child: ConstrainedBox(
					constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							GestureDetector(
								onTap: () => onPhoto(context),
								child: Container(
									padding: EdgeInsets.only(top: 16, bottom: 16),
									height: 150,
									child: imgString == ''
										? Image.asset(ImageConstants.ic_menu_camera, width: 150, height: 150)
										: Utility.imageFromBase64String(imgString),
								),
							),
							SizedBox(
								height: 20,
							),
							projectNameContainer(context),
							SizedBox(
								height: 20,
							),
							genreContainer(context),
							SizedBox(
								height: 20,
							),
							summaryContainer(context),
						],
					),
				),
			),
			floatingActionButton: Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: [
					FloatingActionButton(
						heroTag: 1,

						child: Icon(Icons.delete),
						onPressed: () => showDialogForDelete(),
					),
					SizedBox(width: 20,),
					FloatingActionButton(
						heroTag: 2,

						child: Icon(Icons.save),
						onPressed: () => onUpdate(context),
					),
				],
			));
	}

	projectNameContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						S.of(context).project_name,
						style: TextStyle(fontSize: 20),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						style: TextStyle(color: Colors.black, fontSize: 14),
						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: nameController,
						maxLines: 1,
					),
				],
			),
		));
	}

	genreContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						S.of(context).project_genre,
						style: TextStyle(fontSize: 20),
					),
					SizedBox(
						height: 10,
					),
					genreDropDown(context),
				],
			),
		));
	}

	genreDropDown(BuildContext context) {
		List<String> genreList = StringConstants.genresList(context);
		if (genre == "") {
			setState(() {
				genre = genreList[0];
			});
		}
		return (Container(
			child: DropdownButton<String>(
				value: genre,
				icon: Icon(Icons.arrow_drop_down),
				iconSize: 24,
				style: TextStyle(fontSize: 18, color: Colors.black),
				isExpanded: true,
				onChanged: (String data) {
					setState(() {
						genre = data;
					});
				},
				items: genreList.map((e) {
					return DropdownMenuItem(
						value: e,
						child: Text(e),
					);
				}).toList()),
		));
	}

	summaryContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						S.of(context).project_summary,
						style: TextStyle(fontSize: 20),
					),
					SizedBox(
						height: 10,
					),
					Container(
						height: 200,
						child: TextField(
							controller: summaryController,
							keyboardType: TextInputType.multiline,
							maxLines: null,
							expands: true,
						))
				],
			),
		));
	}

	Future<void> showDialogForDelete() async {
		return showDialog<void>(
			context: context,
			barrierDismissible: true, // user must tap button!
			builder: (BuildContext context) {
				return AlertDialog(
					backgroundColor: Colors.grey,
					title: Row(
						children: <Widget>[
							Icon(Icons.warning,color: Colors.white,),
							Expanded(
								child: SizedBox(
									child: Padding(
										padding: EdgeInsets.all(3.0),
										child: Text(S.of(context).delete_character_btn, style: TextStyle(fontSize: 16, color: Colors.black),),
									)
								),
							)

						],
					),
					content: SingleChildScrollView(
						child: ListBody(
							children: <Widget>[
								Text(S.of(context).delete_project_btn_message, style: TextStyle(color: Colors.white),),
							],
						),
					),
					actions: <Widget>[
						FlatButton(
							child: Text(S.of(context).cancel),
							textColor: Colors.black,
							onPressed: () {
								Navigator.of(context).pop();
							},
						),
						FlatButton(
							child: Text('OK'),
							textColor: Colors.black,
							onPressed: () {
								Future.delayed(Duration.zero, this.onDelete);
							},
						),
					],
				);
			},
		);
	}
}
