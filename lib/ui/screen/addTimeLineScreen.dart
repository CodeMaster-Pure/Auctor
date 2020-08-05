import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/ui/screen/challengeScreen.dart';
import 'package:plotgenerator/ui/screen/offCharacterDetailScreen.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';

import 'package:plotgenerator/model/Timeline.dart';
import '../../engine/colors.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class AddTimeLineScreen extends StatefulWidget {
	final bool isNew;
	AddTimeLineScreen({this.isNew});

	@override
	AddTimeLineScreenState createState() => AddTimeLineScreenState(isNew: isNew);
}

class AddTimeLineScreenState extends State<AddTimeLineScreen> {

	AddTimeLineScreenState({this.isNew});

	final bool isNew;
	final titleController = TextEditingController();
	final descriptionController = TextEditingController();
	final dateController = TextEditingController();
	int sortIntIndex = 0;

	@override
	void initState() {
		super.initState();
		if (!isNew) {
			titleController.text = Common.currentTimeline.title;
			descriptionController.text = Common.currentTimeline.description;
			dateController.text = Common.currentTimeline.date;
		}
	}

	@override
	void dispose() {
		titleController.dispose();
		descriptionController.dispose();
		super.dispose();
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
				title: Text(''),
			),
			body: bodyContainer(context),
			floatingActionButton: customFloatingActionButtion()
		);
	}

	customFloatingActionButtion() {
		if (isNew) {
			return new FloatingActionButton(
				heroTag: 1,
				child: IconButton(
					icon: Icon(
						Icons.save,
					),
					onPressed: (){
						onSave();
					},
				),
			);
		} else {
			return Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: [
					FloatingActionButton(
						heroTag: 2,
						child: IconButton(
							icon: Icon(Icons.save),
						),
						onPressed: (){
							onSave();
						}
					),
					SizedBox(
						width: 10,
					),
					FloatingActionButton(

						heroTag: 3,
						child: IconButton(
							icon: Icon(Icons.delete),
						),
						onPressed: (){
							onDelete();
						},
					),
				],
			);
		}
	}

	onSave() {
		if (isNew){
			Timeline timeline = new Timeline(
				title: titleController.text,
				description: descriptionController.text,
				character_id: Common.currentCharacter.id.toString(),
				position: '0',
				date: dateController.text,
			);

			DatabaseHelper().createTimeline(timeline).then((result){
				if ( result == 1 )
					Fluttertoast.showToast(msg: 'Saved Timeline');
				else
					Fluttertoast.showToast(msg: 'Failed to save the Timeline');
			});
		} else {
			Timeline timeline = new Timeline(
				id: Common.currentTimeline.id,
				title: titleController.text,
				description: descriptionController.text,
				character_id: Common.currentCharacter.id.toString(),
				position: '0',
				date: dateController.text,
			);

			DatabaseHelper().updateTimeline(timeline).then((result){
				if ( result ==1 )
					Fluttertoast.showToast(msg: 'Updated Timeline');
				else
					Fluttertoast.showToast(msg: 'Failed to update the Timeline');
			});
		}
		Navigator.push(context, MaterialPageRoute(builder: (context) => OffCharacterDetailScreen()));
	}

	onDelete() {
		DatabaseHelper().deleteTimeLineByid(Common.currentTimeline.id).then((result){
			if ( result == 1 )
				Fluttertoast.showToast(msg: 'Deleted Timeline');
			else
				Fluttertoast.showToast(msg: 'Failed to delete. Try again');
		});
		Navigator.push(context, MaterialPageRoute(builder: (context) => OffCharacterDetailScreen()));
	}

	bodyContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					SizedBox(
						height: 10,
					),
					Text(
						'Title',
						style: TextStyle(fontSize: 20, color: ColorConstants.headline),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: 'The meet up'
						),
						style: TextStyle(color: Colors.black, fontSize: 14),
						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: titleController,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					Text(
						'Date',
						style: TextStyle(fontSize: 20, color: ColorConstants.headline),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						onTap: (){
							FocusScope.of(context).requestFocus(new FocusNode());
							DatePicker.showDatePicker(
								context,
								onConfirm: (dateTime, selectedIndex) {
									setState(() {
										var formatter = new DateFormat('dd/MM/yyyy');
										sortIntIndex = dateTime.millisecondsSinceEpoch;
										String formatted = formatter.format(dateTime);
									  	dateController.text = formatted;
									});
								},
							);
						},
						decoration: InputDecoration(
							hintText: '8/5/1986'
						),
						style: TextStyle(color: Colors.black, fontSize: 14),
						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: dateController,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					Text(
						'Description',
						style: TextStyle(fontSize: 20, color: ColorConstants.headline),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: 'It wasn\'s an easy day',
						),
						style: TextStyle(color: Colors.black, fontSize: 14),
						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: descriptionController,
						maxLines: 10,
					),
				],
			),
		));
	}

}