import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/generated/i18n.dart';
import '../../engine/colors.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class PremiumScreen extends StatefulWidget {
	@override
	PremiumScreenState createState() => PremiumScreenState();
}

class PremiumScreenState extends State<PremiumScreen> {
	static const String iapId = 'no_ads';
	List<IAPItem> _items = [];

	@override
	void initState() {
		super.initState();
		initPlatformState();
	}

	Future<void> initPlatformState() async {
		var result = await FlutterInappPurchase.instance.initConnection;

		// If the widget was removed from the tree while the asynchronous platform
		// message was in flight, we want to discard the reply rather than calling
		// setState to update our non-existent appearance.
		if (!mounted) return;

		// refresh items for android
//		String msg = await FlutterInappPurchase.instance.consumeAllItems;
//		print('consumeAllItems: $msg');
		await _getProduct();
	}

	Future<Null> _getProduct() async {
		List<IAPItem> items = await FlutterInappPurchase.instance.getProducts([iapId]);
		for (var item in items) {
			print('${item.toString()}');
			this._items.add(item);
		}

		setState(() {
			this._items = items;
		});
	}
	
	void checkForAppStoreInitiatedProducts() async {
		print('IAP iOS ');
		FlutterInappPurchase.instance.getAppStoreInitiatedProducts().then((value){
			if (value.length > 0) {
				FlutterInappPurchase.instance.requestPurchase(value.last.productId); // Buy last product in the list
			}
		});
	}

	Future<Null> _buyProduct(IAPItem item) async {
		try {
			PurchasedItem purchased = await FlutterInappPurchase.instance.requestPurchase(item.productId);

			print(purchased);
			FlutterInappPurchase.purchaseUpdated.listen((event) {
				print('purchase-updated:'+ event.toString());
				FlutterInappPurchase.instance.finishTransaction(purchased);
				Fluttertoast.showToast(msg: 'You will become a premium user soon!');
			});

			FlutterInappPurchase.purchaseError.listen((event) {
				print('purchase-error:'+ event.toString());
				Fluttertoast.showToast(msg: 'Purchase Error! Try again!');
			});
		} catch (error) {
			print('$error');
		}
	}

	@override
	void dispose() async{
		super.dispose();
		await FlutterInappPurchase.instance.endConnection;
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
				title: Text('Premium'),
			),
			body: new Column(
				children: <Widget>[
					new Expanded(
						child: new Container(
							child: ListView(
								shrinkWrap: true,
								padding: const EdgeInsets.all(20.0),

								children: <Widget>[
									Center (
										child: Row (
											mainAxisAlignment: MainAxisAlignment.center,
											children: <Widget>[
												Expanded(
													child: Column (
														mainAxisAlignment: MainAxisAlignment.center,
														children: <Widget>[
															RichText(
																text: TextSpan(
																	text:  Common.currentLanguageEnglish ? 'Why Premium?' : 'it is espanol',
																	style: TextStyle(fontSize: 26, color: ColorConstants.headline, fontFamily: 'typewcond_bold')
																),
															),
															SizedBox(height: 10,),
															Center(
																child: Text(S.of(context).premium_body_test, style: TextStyle (color: Common.premiumTextColor, height: 1.3, fontFamily: 'typewcond_regular', fontSize: 20),
																	textAlign: TextAlign.center,
																),
															),
														],
													),
												)
											],
										),
									),
								],
							)
						),
					),
					Image.asset(ImageConstants.premiumOwlImgPath, width: 180, height: 180,),
					!Common.isPAU ?
					Container(
						alignment: Alignment.center,
						color: ColorConstants.headline,
						margin: EdgeInsets.all(10),
						height: 50,
						child: FlatButton(
							child: Text("BUY US A COFFEE", style: TextStyle(color: Colors.white , fontSize: 30.0, fontFamily: 'archristy')),
							onPressed: () {
								if (Common.currentDeviceType == 'Android') {
									print('android');
									_buyProduct(_items.first);
								} else if (Common.currentDeviceType == 'iPhone') {
									checkForAppStoreInitiatedProducts();
								} else {
									Fluttertoast.showToast(msg: 'Unknow Device!');
								}
							},
						)
					) : Container(height: 50,),
					SizedBox(
						height: 10,
					)
				]
			)
		);
	}
}