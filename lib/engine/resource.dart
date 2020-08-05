import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'colors.dart';

class ThemeConstants {
	static int index;
	static ThemeData currentTheme(BuildContext context, theme) {
		ThemeData themeData = Theme.of(context).copyWith();
		switch (theme) {
			case 0:
				return Theme.of(context).copyWith(
					primaryColor: ColorConstants.colorPrimary,
					floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
						backgroundColor: ColorConstants.headline
					),
					primaryColorDark: ColorConstants.colorPrimaryDark,
					accentColor: ColorConstants.colorAccent,
//					dialogBackgroundColor: ColorConstants.windowBackground,
					backgroundColor: ColorConstants.background,
//					scaffoldBackgroundColor: ColorConstants.windowBackground,
					textTheme: TextTheme(
						bodyText2: TextStyle(color: ColorConstants.headline),
						subtitle2: TextStyle(color: ColorConstants.colorPrimaryDark),
						bodyText1: TextStyle(color: ColorConstants.colorPrimaryDark),
						headline6: TextStyle(color: Colors.black),
						headline1: TextStyle(color: Colors.black),
					));
				break;
			case 1:
				return Theme.of(context).copyWith(
					primaryColor: MetalTheme.colorPrimary,
					floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
						backgroundColor: MetalTheme.backgroundDarker
					),
					primaryColorDark: MetalTheme.colorPrimaryDark,
					accentColor: MetalTheme.colorAccent,
					dialogBackgroundColor: MetalTheme.windowBackground,
					backgroundColor: MetalTheme.colorBackground,
					scaffoldBackgroundColor: MetalTheme.windowBackground,
					textTheme: TextTheme(
						bodyText2: TextStyle(color: ColorConstants.headline),
						subtitle2: TextStyle(color: MetalTheme.backgroundDarker),
						bodyText1: TextStyle(color: MetalTheme.backgroundDarker),
						headline6: TextStyle(color: Colors.black),
						headline1: TextStyle(color: Colors.black),
						subtitle1: TextStyle(color: Colors.black),
					));
				break;
			case 2:
				return Theme.of(context).copyWith(
					primaryColor: DarkTheme.colorPrimary,
					primaryColorDark: DarkTheme.colorPrimaryDark,
					accentColor: DarkTheme.colorAccent,
					dialogBackgroundColor: DarkTheme.windowBackground,
					backgroundColor: DarkTheme.colorBackground,
					scaffoldBackgroundColor: DarkTheme.windowBackground,
					floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
						backgroundColor: DarkTheme.backgroundDarker
					),
					textTheme: TextTheme(
						bodyText2: TextStyle(color: ColorConstants.headline),
						subtitle2: TextStyle(color: Colors.white),
						bodyText1: TextStyle(color: Colors.black),
						headline6: TextStyle(color: Colors.black),
						headline1: TextStyle(color: Colors.black),
						subtitle1: TextStyle(color: Colors.black),
					));

				break;
			case 3:
				return Theme.of(context).copyWith(
					primaryColor: OpaqueTheme.colorPrimary,
					primaryColorDark: OpaqueTheme.colorPrimaryDark,
					accentColor: OpaqueTheme.colorAccent,
					floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
						backgroundColor: OpaqueTheme.backgroundDarker
					),
					textTheme: TextTheme(
						bodyText2: TextStyle(color: ColorConstants.headline),
						subtitle2: TextStyle(color: OpaqueTheme.backgroundDarker),
						bodyText1: TextStyle(color: OpaqueTheme.backgroundDarker),
						headline6: TextStyle(color: Colors.black),
						headline1: TextStyle(color: Colors.black),
						subtitle1: TextStyle(color: Colors.black),
					));
				break;

			case 4:
				return Theme.of(context).copyWith(
					primaryColor: AutumnTheme.colorPrimary,
					primaryColorDark: AutumnTheme.colorPrimaryDark,
					accentColor: AutumnTheme.colorAccent,
					backgroundColor: AutumnTheme.colorBackground,
					floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
						backgroundColor: AutumnTheme.backgroundDarker
					),
					textTheme: TextTheme(
						bodyText2: TextStyle(color: ColorConstants.headline),
						subtitle2: TextStyle(color: AutumnTheme.backgroundDarker),
						bodyText1: TextStyle(color: AutumnTheme.backgroundDarker),
						headline6: TextStyle(color: Colors.black),
						headline1: TextStyle(color: Colors.black),
						subtitle1: TextStyle(color: Colors.black),
					));
				break;
			case 5:
				return Theme.of(context).copyWith(
					primaryColor: WhiteTheme.colorPrimary,
					primaryColorDark: WhiteTheme.colorPrimaryDark,
					accentColor: WhiteTheme.colorAccent,
					backgroundColor: WhiteTheme.colorBackground,
					floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
						backgroundColor: WhiteTheme.backgroundDarker
					),
					textTheme: TextTheme(
						bodyText2: TextStyle(color: ColorConstants.headline),
						subtitle2: TextStyle(color: Colors.black),
						bodyText1: TextStyle(color: Colors.black),
						headline6: TextStyle(color: Colors.black),
						headline1: TextStyle(color: Colors.black),
						subtitle1: TextStyle(color: Colors.black),
					));
				break;
			default:
				return Theme.of(context).copyWith(
					primaryColor: MetalTheme.colorPrimary,
					floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
						backgroundColor: MetalTheme.backgroundDarker
					),
					primaryColorDark: MetalTheme.colorPrimaryDark,
					accentColor: MetalTheme.colorAccent,
					dialogBackgroundColor: MetalTheme.windowBackground,
					backgroundColor: MetalTheme.colorBackground,
					scaffoldBackgroundColor: MetalTheme.windowBackground,
					textTheme: TextTheme(
						bodyText2: TextStyle(color: ColorConstants.headline),
						subtitle2: TextStyle(color: MetalTheme.backgroundDarker),
						bodyText1: TextStyle(color: MetalTheme.backgroundDarker),
						headline6: TextStyle(color: Colors.black),
						headline1: TextStyle(color: Colors.black),
						subtitle1: TextStyle(color: Colors.black),
					));
				break;
		}
	}
}

class ImageConstants {
	static const SideMenuWorkshop = "assets/images/sidemenu_workshop.svg";
	static const SideMenuChallenge = "assets/images/sidemenu_challenge.png";
	static const SideMenuPrompts = "assets/images/sidemenu_prompt.svg";
	static const SideMenuPremium = "assets/images/sidemenu_premium.png";
	static const SideMenuProfile = "assets/images/sidemenu_profile.svg";
	static const premiumOwlImgPath = "assets/images/premium_owl.png";
	static const typeWriterImgPath = "assets/images/typewriter.png";
	static const ic_book_black = "assets/images/ic_book_black.svg";
	static const ic_character_black = "assets/images/ic_character_black.svg";
	static const ic_menu_save = "assets/images/ic_menu_save.png";
	static const ic_random = "assets/images/random_icon.png";
	static const ic_menu_camera = "assets/images/ic_menu_camera.png";
	static const ic_menu_edit = 'assets/images/ic_menu_edit.png';
	static const ic_comment = 'assets/images/ic_comment.png';
	static const ic_love_red = 'assets/images/ic_love_red.png';
	static const challenge_icon = 'assets/images/challenge_icon.png';
	static const hero_bkg = 'assets/images/hero.png';
	static const hero_bkg2 = 'assets/images/hero2.png';
}

class StringConstants {
	static List<String> genresList(BuildContext context) {
		List<String> results = [];
		results.add(S.of(context).genres_array_0);
		results.add(S.of(context).genres_array_1);
		results.add(S.of(context).genres_array_2);
		results.add(S.of(context).genres_array_3);
		results.add(S.of(context).genres_array_4);
		results.add(S.of(context).genres_array_5);
		results.add(S.of(context).genres_array_6);
		results.add(S.of(context).genres_array_7);
		results.add(S.of(context).genres_array_8);
		results.add(S.of(context).genres_array_9);
		results.add(S.of(context).genres_array_10);
		results.add(S.of(context).genres_array_11);
		results.add(S.of(context).genres_array_12);
		results.add(S.of(context).genres_array_13);
		results.add(S.of(context).genres_array_14);
		results.add(S.of(context).genres_array_15);
		return results;
	}

	static List<String> genderList(BuildContext context) {
		List<String> results = [];
		results.add(S.of(context).gender_spinner_array_0);
		results.add(S.of(context).gender_spinner_array_1);
		results.add(S.of(context).gender_spinner_array_2);
		results.add(S.of(context).gender_spinner_array_3);
		results.add(S.of(context).gender_spinner_array_4);
		results.add(S.of(context).gender_spinner_array_5);

		return results;
	}

	static List<String> storyList(BuildContext context) {
		List<String> results = [];
		results.add(S.of(context).char_guide_types_titles_0);
		results.add(S.of(context).char_guide_types_titles_1);
		results.add(S.of(context).char_guide_types_titles_2);
		results.add(S.of(context).char_guide_types_titles_3);
		results.add(S.of(context).char_guide_types_titles_4);
		results.add(S.of(context).char_guide_types_titles_5);
		results.add(S.of(context).char_guide_types_titles_6);
		results.add(S.of(context).char_guide_types_titles_7);
		results.add(S.of(context).char_guide_types_titles_8);
		results.add(S.of(context).char_guide_types_titles_9);
		results.add(S.of(context).char_guide_types_titles_10);

		return results;
	}
}
