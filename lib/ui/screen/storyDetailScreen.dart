import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/main.dart';
import 'package:plotgenerator/model/Comment.dart';
import 'package:plotgenerator/ui/screen/profileScreen.dart';

import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'promptsScreen.dart';

class StoryDetailScreen extends StatefulWidget {
	StoryDetailScreen();
	@override
	StoryDetailScreenState createState() => StoryDetailScreenState();
}

class StoryDetailScreenState extends State<StoryDetailScreen> {

	StoryDetailScreenState();

	final commentController = TextEditingController();
	bool _validate = false;
	bool isLike;

	@override
	void initState() {
		super.initState();
		if ( Common.currentStory.likesMap.containsKey(Common.currentUser.uid)) {
			isLike = true;
		} else {
			isLike = false;
		}
	}

	@override
	void dispose() {
		commentController.dispose();
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
		double width = MediaQuery.of(context).size.width;
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
			body: SingleChildScrollView(
				padding: EdgeInsets.all(10.0),
				child: ConstrainedBox(
					constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
					child: Column(
						children: <Widget>[
							Padding(
								padding: EdgeInsets.all(0.0),
								child: Image.asset(ImageConstants.typeWriterImgPath, height: 150, width: width-10, fit: BoxFit.fill,),
							),

							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Padding(
										padding: EdgeInsets.all(0.0),
										child: new Text(Common.currentStory.title, style: TextStyle(fontFamily: 'roboto_lightitalic', fontSize: 18),),
									),
									Padding(
										padding: EdgeInsets.all(5.0),
										child: CircleAvatar(
											radius: 25.0,
											backgroundImage: NetworkImage(Common.currentStory.user['uriString']),
											backgroundColor: Colors.transparent,
										),
									),
								],
							),
							Padding(
								padding: EdgeInsets.all(0.0),
								child: new Text(Common.currentStory.challenge, maxLines: 150, style: TextStyle(color: Common.premiumTextColor),),
							),
							Row(
								children: <Widget>[
									isLike ? IconButton(
										icon: Icon(Icons.favorite, color: Colors.red),
										onPressed: () {
											onLike();
										}) : IconButton(
										icon: Icon(Icons.favorite_border),
										onPressed: () {
											onLike();
										}),


									Text(Common.currentStory.likeCount.toString(), style: TextStyle(fontFamily: 'typewcond_regular'),),
									SizedBox(width: 10,),
									Text('Likes', style: TextStyle(fontFamily: 'typewcond_regular')),
									SizedBox(width: 10,),
									SizedBox(
										width: 26,
										height: 26,
										child: Image.asset(ImageConstants.ic_comment),
									),
									SizedBox(width: 10,),
									Text(Common.commentCount.toString(), style: TextStyle(fontFamily: 'typewcond_regular')),
									SizedBox(width: 10,),
									Text('Comments', style: TextStyle(fontFamily: 'typewcond_regular')),
									IconButton(
										icon: Icon(Icons.share),
										onPressed: () {
											share(Common.currentStory.challenge);
										}
									),
								],
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									SizedBox(
										width: width - 100,
										child: TextField(
											decoration: InputDecoration(
												errorText: _validate ? 'Required' : null,
												errorStyle: TextStyle(
													color: Colors.red
												),
												hintText: S.of(context).write_a_comment
											),
											style: TextStyle( fontSize: 14, fontFamily: 'typewcond_regular'),
//											cursorColor: Colors.black,
											onChanged: (value) {},
											controller: commentController,
											maxLines: 1,
										),
									),
									SizedBox(
										width: 80,
										child: FlatButton(
											child: Text(S.of(context).post, style: TextStyle(fontFamily: 'typewcond_regular'),),
											onPressed: (){
												saveComment();
											},
										)
									)
								],
							),
							Container(
								child: StreamBuilder(
									stream: Common.currentLanguageEnglish ?
									Firestore.instance.collection('weekly_participants_en').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(Common.currentStory.id).collection('Comments').snapshots() :
									Firestore.instance.collection('weekly_participants_es').document(Common.currentWeeklyStoryTitle).collection('post-comments').document(Common.currentStory.id).collection('Comments').snapshots(),
									builder: (context, snapshot) {
										if (snapshot.hasData) {
											return Column(
												children: List.generate(snapshot.data.documents.length, (index) {
													return buildItem(context, snapshot.data.documents[index]);
												}),
											);
										} else {
											return Container();
										}
									},
								),
							),
						],
					),
				),
			),
		);
	}

	void saveComment(){
		setState(() {
			if ( commentController.text.isEmpty) {
				_validate = true;
				return;
			} else {
				_validate = false;
				Future.delayed(Duration.zero, this.save);
			}
		});
	}


	onLike(){
		if (!Common.currentStory.likesMap.containsKey(Common.currentUser.uid)) {
			Common.currentStory.likeCount++;
			Common.currentStory.likesMap[Common.currentUser.uid] = true;
			setState(() {
				isLike = true;
			});
		} else {
			Common.currentStory.likeCount--;
			Common.currentStory.likesMap.remove(Common.currentUser.uid);
			setState(() {
				isLike = false;
			});
		}
		updateLikes();
	}

	Future<void> updateLikes() async {
		try {
			if(Common.currentLanguageEnglish) {
				Firestore.instance.document(S
					.of(context)
					.weekly_challenge_db_name + '/' +
					Common.currentWeeklyStoryTitle + '/posts/' +
					Common.currentStory.id)
					.setData(Common.currentStory.toMap())
					.then((result) {
					Fluttertoast.showToast(msg: 'Like!');
				});
			} else {
				Firestore.instance.document('weekly_participants_es/' +
					Common.currentWeeklyStoryTitle + '/posts/' +
					Common.currentStory.id)
					.setData(Common.currentStory.toMap())
					.then((result) {
					Fluttertoast.showToast(msg: 'Like!');
				});
			}
		}  catch (e) {
			// throw the Firebase AuthException that we caught
			throw new Exception(e.toString());
		}
	}

	Future<void> save() async {
		int date = (DateTime.now().millisecondsSinceEpoch / 1000).round();
		Comment comment = new Comment(userId: Common.currentUser.uid, userName: Common.currentUser.name, userPic: Common.currentUser.uriString, userComment: commentController.text, userDate: date);
		try {
			String dbname = S.of(context).weekly_challenge_db_name;
			if ( !Common.currentLanguageEnglish) {
				dbname = 'weekly_participants_es';
			}

			String id = Firestore.instance
				.collection(dbname)
				.document(Common.currentWeeklyStoryTitle)
				.collection('post-comments')
				.document(Common.currentStory.id)
				.collection('Comments')
				.document().documentID;

			Firestore.instance
				.collection(dbname)
				.document(Common.currentWeeklyStoryTitle)
				.collection('post-comments')
				.document(Common.currentStory.id)
				.collection('Comments').add(comment.toMap()).then((result){
					Fluttertoast.showToast(msg: 'Save comment!');
					commentController.text = '';
				});
		}  catch (e) {
			// throw the Firebase AuthException that we caught
			throw new Exception(e.toString());
		}
	}

	Widget buildItem(BuildContext context, DocumentSnapshot documentSnapshot) {
		double width = MediaQuery.of(context).size.width;
		int commentCount = 0;
		return Container(
			width: width,
			child: Row(
				children: <Widget>[
					SizedBox(
						height: 70,
					),
					Expanded(
						flex: 2,
						child: Center(
							child: SizedBox(
								width: 30,
								height: 30,
								child: CircleAvatar(
//								radius: 25.0,
									backgroundImage: NetworkImage(documentSnapshot.data['userPic']),
									backgroundColor: Colors.transparent,
								),
							)
						),
					),
					Expanded(
						flex: 8,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text(documentSnapshot.data['userName'], style: TextStyle(fontFamily: 'typewcond_regular')),
								Text(documentSnapshot.data['userComment'], style: TextStyle(color: Common.premiumTextColor, fontFamily: 'typewcond_regular'),),
							],
						),
					)

				],
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
}


