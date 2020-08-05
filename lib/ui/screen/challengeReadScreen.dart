import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/model/Story.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';
import 'package:plotgenerator/ui/screen/storyDetailScreen.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class ChallengeReadScreen extends StatefulWidget {

	ChallengeReadScreen();
	@override
	ChallengeReadScreenState createState() => ChallengeReadScreenState();
}

class ChallengeReadScreenState extends State<ChallengeReadScreen> {

	ChallengeReadScreenState();

	@override
	void initState() {
		super.initState();
	}

	@override
	void dispose() {
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

	gotoStoryDetailScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => StoryDetailScreen()));
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
				title: Text('Weekly Challenge'),
			),
			body: new DefaultTabController(
				length: 3,
				child: new Scaffold(
					appBar: new AppBar(
						actions: <Widget>[],
						title: new TabBar(
							tabs: [
								Padding(
									padding: EdgeInsets.fromLTRB(0, 19, 0, 19),
									child: new Text('MOST VOTED',),
								),
								Padding(
									padding: EdgeInsets.fromLTRB(0, 19, 0, 19),
									child: new Text('RECENT'),
								),
								Padding(
									padding: EdgeInsets.fromLTRB(0, 19, 0, 19),
									child: new Text('MY STORY'),
								),

							],
							indicatorColor: Colors.white,
						),
						automaticallyImplyLeading: false,
					),
					body: new TabBarView(
						children: [
							Stack(
								children: <Widget>[
									Container(
										child: StreamBuilder(
											stream: Common.currentLanguageEnglish ? Firestore.instance.collection('weekly_participants_en').document(Common.currentWeeklyStoryTitle).collection('posts').orderBy('likeCount', descending: true).snapshots() :
																					Firestore.instance.collection('weekly_participants_es').document(Common.currentWeeklyStoryTitle).collection('posts').orderBy('likeCount', descending: true).snapshots(),
											builder: (context, snapshot) {
												if (snapshot.hasData) {
													return ListView.builder(
														itemBuilder: (context, index) =>
															mostStoryBuildItem(context, snapshot.data.documents[index]),
														itemCount: snapshot.data.documents.length,
													);
												} else {
													return Container(
														child: Center(
															child: Text(S.of(context).weekly_challenge_desc_default),
														),
													);
												}
											},
										),
									),
								],
							),

							Stack(
								children: <Widget>[
									Container(
										child: StreamBuilder(
											stream: Common.currentLanguageEnglish ? Firestore.instance.collection('weekly_participants_en').document(Common.currentWeeklyStoryTitle).collection('posts').orderBy('date', descending: true).snapshots() :
																					Firestore.instance.collection('weekly_participants_es').document(Common.currentWeeklyStoryTitle).collection('posts').orderBy('date', descending: true).snapshots(),
											builder: (context, snapshot) {
												if (snapshot.hasData) {
													return ListView.builder(
														itemBuilder: (context, index) =>
															recentStoryBuildItem(context, snapshot.data.documents[index]),
														itemCount: snapshot.data.documents.length,
													);
												} else {
													return Container(
														child: Center(
															child: Text(S.of(context).weekly_challenge_desc_default),
														),
													);
												}
											},
										),
									),
								],
							),
							Stack(
								children: <Widget>[
									Container(
										child: StreamBuilder(
											stream: Common.currentLanguageEnglish ?
														Firestore.instance.collection('weekly_participants_en').document(Common.currentWeeklyStoryTitle).collection('posts').where('user.email', isEqualTo: Common.currentUser.email).snapshots() :
														Firestore.instance.collection('weekly_participants_es').document(Common.currentWeeklyStoryTitle).collection('posts').where('user.email', isEqualTo: Common.currentUser.email).snapshots(),
											builder: (context, snapshot) {
												if (snapshot.hasData && snapshot.data.documents.length != 0) {
													return ListView.builder(
														itemBuilder: (context, index) =>
															myStoryBuildItem(context, snapshot.data.documents[index]),
														itemCount: snapshot.data.documents.length,
													);
												} else {
													return Container(
														child: Center(
															child: Text('No story', style: TextStyle(color: Colors.black),),
														),
													);
												}
											},
										),
									),
								],
							),
						],
					),
				),
			),
		);
	}



	Widget mostStoryBuildItem(BuildContext context, DocumentSnapshot document) {
		bool isLike = false;
		Story story = Story.fromMap(document.data);
		if (story.likesMap != null ) {
			if (story.likesMap.containsKey(Common.currentUser.uid)) {
				isLike = true;
			}
		}
		int count = 0;
		double width = MediaQuery.of(context).size.width;
		return StreamBuilder(
				stream: Common.currentLanguageEnglish ?
				Firestore.instance.collection('weekly_participants_en').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(story.id).collection('Comments').snapshots() :
				Firestore.instance.collection('weekly_participants_es').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(story.id).collection('Comments').snapshots(),
				builder: (context, snapshot) {
				if (!snapshot.hasData)
					count = 0;
				else {
					count = snapshot.data.documents.length;
				}
				return
					Container(
						child: FlatButton(
							child: Row(
								children: <Widget>[
									Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Row(
												children: <Widget>[
													Padding(
														padding: EdgeInsets.all(10.0),
														child: CircleAvatar(
															radius: 25.0,
															backgroundImage: NetworkImage(story.user['uriString']),
															backgroundColor: Colors.transparent,
														),
													),

													Text('${story.user['name']}', style: TextStyle(fontFamily: 'roboto_bolditalic', fontSize: 18, color: Common.storyDetailTextColor)),
												],
											),
											new Image.asset(ImageConstants.typeWriterImgPath, height: 150, width: width-10, fit: BoxFit.fill,),

											Padding(
												padding: EdgeInsets.all(10.0),
												child: new Text(Common.currentWeeklyStoryTitle, style: TextStyle(fontFamily: 'roboto_bolditalic', fontSize: 18, color: Common.storyDetailTextColor),),
											),

											new Container (
												padding: const EdgeInsets.all(5.0),
												width: width - 10,
												height: 100,
												child: new Column (
													children: <Widget>[
														new Text (story.challenge, textAlign: TextAlign.left, maxLines: 4, style: TextStyle(color: Common.containerBackColor, fontFamily: 'roboto_regular', fontSize: 16),),
													],
												),
											),
											Row(
												children: <Widget>[
													isLike ? IconButton(
														icon: Icon(Icons.favorite, color: Colors.red,),
														onPressed: () {}) : IconButton(
														icon: Icon(Icons.favorite_border, color: Common.containerBackColor,),
														onPressed: () {}) ,
													Text(story.likeCount.toString(), style: TextStyle(fontFamily: 'typewcond_regular')),
													SizedBox(width: 10,),
													Text('Likes', style: TextStyle(fontFamily: 'typewcond_regular'),),
													SizedBox(width: 10,),
													SizedBox(
														width: 26,
														height: 26,
														child: Image.asset(ImageConstants.ic_comment),
													),
													SizedBox(width: 10,),
													Text(count.toString(), style: TextStyle(fontFamily: 'typewcond_regular')),
													SizedBox(width: 10,),
													Text('Comments', style: TextStyle(fontFamily: 'typewcond_regular')),
												],
											)
										],
									),


								],
							),
							onPressed: () {
								Common.commentCount = count;
								Common.currentStory = story;
								gotoStoryDetailScreen(context);
							},
							color: Colors.grey[300],
							padding: EdgeInsets.all(0.0),
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
						),
						margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
					);


			},
		);
	}

	Widget recentStoryBuildItem(BuildContext context, DocumentSnapshot document) {
		bool isLike = false;
		Story story = Story.fromMap(document.data);
		if (story.likesMap != null ) {
			if (story.likesMap.containsKey(Common.currentUser.uid)) {
				isLike = true;
			}
		}
		int count = 0;
		double width = MediaQuery.of(context).size.width;
		return StreamBuilder(
			stream: Common.currentLanguageEnglish ?
			Firestore.instance.collection('weekly_participants_en').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(story.id).collection('Comments').snapshots() :
			Firestore.instance.collection('weekly_participants_es').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(story.id).collection('Comments').snapshots(),
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					count = 0;
				else {
					count = snapshot.data.documents.length;
				}
				return
					Container(
						child: FlatButton(
							child: Row(
								children: <Widget>[
									Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Row(
												children: <Widget>[
													Padding(
														padding: EdgeInsets.all(10.0),
														child: CircleAvatar(
															radius: 25.0,
															backgroundImage: NetworkImage(story.user['uriString']),
															backgroundColor: Colors.transparent,
														),
													),

													Text('${story.user['name']}', style: TextStyle(fontFamily: 'roboto_bolditalic', fontSize: 18, color: Common.storyDetailTextColor)),
												],
											),
											new Image.asset(ImageConstants.typeWriterImgPath, height: 150, width: width-10, fit: BoxFit.fill,),

											Padding(
												padding: EdgeInsets.all(10.0),
												child: new Text(Common.currentWeeklyStoryTitle, style: TextStyle(fontFamily: 'roboto_bolditalic', fontSize: 18, color: Common.storyDetailTextColor),),
											),

											new Container (
												padding: const EdgeInsets.all(5.0),
												width: width - 10,
												height: 100,
												child: new Column (
													children: <Widget>[
														new Text (story.challenge, textAlign: TextAlign.left, maxLines: 4, style: TextStyle(color: Common.containerBackColor, fontFamily: 'roboto_regular', fontSize: 16),),
													],
												),
											),
											Row(
												children: <Widget>[
													isLike ? IconButton(
														icon: Icon(Icons.favorite, color: Colors.red,),
														onPressed: () {}) : IconButton(
														icon: Icon(Icons.favorite_border, color: Common.containerBackColor,),
														onPressed: () {}) ,
													Text(story.likeCount.toString(), style: TextStyle(fontFamily: 'typewcond_regular')),
													SizedBox(width: 10,),
													Text('Likes', style: TextStyle(fontFamily: 'typewcond_regular'),),
													SizedBox(width: 10,),
													SizedBox(
														width: 26,
														height: 26,
														child: Image.asset(ImageConstants.ic_comment),
													),
													SizedBox(width: 10,),
													Text(count.toString(), style: TextStyle(fontFamily: 'typewcond_regular')),
													SizedBox(width: 10,),
													Text('Comments', style: TextStyle(fontFamily: 'typewcond_regular')),
												],
											)
										],
									),


								],
							),
							onPressed: () {
								Common.commentCount = count;
								Common.currentStory = story;
								gotoStoryDetailScreen(context);
							},
							color: Colors.grey[300],
							padding: EdgeInsets.all(0.0),
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
						),
						margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
					);


			},
		);
	}

	Widget myStoryBuildItem(BuildContext context, DocumentSnapshot document) {
		bool isLike = false;
		Story story = Story.fromMap(document.data);
		if (story.likesMap != null ) {
			if (story.likesMap.containsKey(Common.currentUser.uid)) {
				isLike = true;
			}
		}
		int count = 0;
		double width = MediaQuery.of(context).size.width;
		return StreamBuilder(
			stream: Common.currentLanguageEnglish ?
			Firestore.instance.collection('weekly_participants_en').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(story.id).collection('Comments').snapshots() :
			Firestore.instance.collection('weekly_participants_es').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(story.id).collection('Comments').snapshots(),
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					count = 0;
					return(Text('No Story'));
				} else {
					count = snapshot.data.documents.length;
					return Container(
						child: FlatButton(
							child: Row(
								children: <Widget>[
									Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Row(
												children: <Widget>[
													Padding(
														padding: EdgeInsets.all(10.0),
														child: CircleAvatar(
															radius: 25.0,
															backgroundImage: NetworkImage(story.user['uriString']),
															backgroundColor: Colors.transparent,
														),
													),
													
													Text('${story.user['name']}', style: TextStyle(fontFamily: 'roboto_bolditalic', fontSize: 18, color: Common.storyDetailTextColor)),
												],
											),
											new Image.asset(ImageConstants.typeWriterImgPath, height: 150, width: width-10, fit: BoxFit.fill,),
											
											Padding(
												padding: EdgeInsets.all(10.0),
												child: new Text(Common.currentWeeklyStoryTitle, style: TextStyle(fontFamily: 'roboto_bolditalic', fontSize: 18, color: Common.storyDetailTextColor),),
											),
											
											new Container (
												padding: const EdgeInsets.all(5.0),
												width: width - 10,
												height: 100,
												child: new Column (
													children: <Widget>[
														new Text (story.challenge, textAlign: TextAlign.left, maxLines: 4, style: TextStyle(color: Common.containerBackColor, fontFamily: 'roboto_regular', fontSize: 16),),
													],
												),
											),
											Row(
												children: <Widget>[
													isLike ? IconButton(
														icon: Icon(Icons.favorite, color: Colors.red,),
														onPressed: () {}) : IconButton(
														icon: Icon(Icons.favorite_border, color: Common.containerBackColor,),
														onPressed: () {}) ,
													Text(story.likeCount.toString(), style: TextStyle(fontFamily: 'typewcond_regular')),
													SizedBox(width: 10,),
													Text('Likes', style: TextStyle(fontFamily: 'typewcond_regular'),),
													SizedBox(width: 10,),
													SizedBox(
														width: 26,
														height: 26,
														child: Image.asset(ImageConstants.ic_comment),
													),
													SizedBox(width: 10,),
													Text(count.toString(), style: TextStyle(fontFamily: 'typewcond_regular')),
													SizedBox(width: 10,),
													Text('Comments', style: TextStyle(fontFamily: 'typewcond_regular')),
												],
											)
										],
									),
								
								
								],
							),
							onPressed: () {
								Common.commentCount = count;
								Common.currentStory = story;
								gotoStoryDetailScreen(context);
							},
							color: Colors.grey[300],
							padding: EdgeInsets.all(0.0),
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
						),
						margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
					);
				}
				
			},
		);
	}
}

