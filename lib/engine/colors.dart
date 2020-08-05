import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager {

}

class ColorConstants {
	static const colorPrimary = Color(0xFF37966F);
	static const colorPrimaryDark = Color(0xFF356859);
	static const colorAccent = Color(0xFFFD5523);
	static const headline_classic = Color(0xFFFD5523);
	static const content = Color(0xFF356859);
	static const charListRecColor = Color(0xFF224339);
	static const content_lighter = Color(0xFF0537966f);
	static const background = Color(0xFFFFFBE6);
	static const text_color = Color(0xFF000000);

//	<!--Metal theme-->
	static const colorMetalBackground = Color(0xFFe9e9e9);

//	<!--Dark Theme -->
	static const colorPrimary_2 = Color(0xFF263238);
	static const colorPrimaryDark_2 = Color(0xFF000a12);
	static const colorAccent_2 = Color(0xFF4f5b62);
	static const background_2 = Color(0xFF364750);
	static const text_color_2 = Color(0xFFffffff);
	static const headline_2 = Color(0xFFF9AA33);
	static const content_2 = Color(0xFFffffff);
	static const hint_color = Color(0xFF9fffffff);
	static const charListRecColor_2 = Color(0xFFc72acf);
	static const content_lighter_2 = Color(0xFF0537966f);

	static const colorPrimary_3 = Color(0xFFE91E63);
	static const colorPrimaryDark_3 = Color(0xFF880E4F);
	static const colorAccent_3 = Color(0xFFC51162);
	static const background_3 = Color(0xFFFCE4EC);
	static const headline_3 = Color(0xFFC51162);
	static const content_3 = Color(0xFF000a12);
	static const charListRecColor_3 = Color(0xFF000a12);

//	<!--Autumn Theme -->
	static const colorPrimary_4 = Color(0xFFf2b95d);
	static const colorPrimaryDark_4 = Color(0xFF232F34);
	static const colorAccent_4 = Color(0xFFd67748);
	static const background_4 = Color(0xFFFFFBE6);
	static const headline_4 = Color(0xFFd67748);
	static const charListRecColor_4 = Color(0xFFd67748);


	static const headline = Color(0xFFFD5523);

	static const light_font = Color(0xFFfbfbfb);
	static const grey_font = Color(0xFF272121);
	static const white = Color(0xFFffffff);
	static const black = Color(0xFF000000);
	static const transparent = Color(0x00000000);
	static const text_shadow = Color(0x7f050000);
	static const text_shadow_white = Color(0xFF383737);

	static const color_trigger_1 = Color(0xFF5f5f8c);
	static const color_trigger_2 = Color(0xFF52527b);
	static const color_trigger_3 = Color(0xFF373753);
	static const color_trigger_4 = Color(0xFF28283d);
	static const color_trigger_5 = Color(0xFF13131d);
	static const background_material_light = Color(0xFFbaa647);

	static const dialogBackgroundColor = Color(0xFF29434e);
	static const dialogTitleColor = Color(0xFF3bc13d);
}

class AppTheme {
	static const colorPrimary = ColorConstants.colorPrimary;
	static const colorPrimaryDark = ColorConstants.colorPrimaryDark;
	static const colorAccent = ColorConstants.colorAccent;
	static const windowBackground = ColorConstants.background;
	static const colorBackground = ColorConstants.background;
	static const colorDivider = ColorConstants.colorPrimary;
	static const textColor = ColorConstants.text_color;
	static const textColorPrimary = ColorConstants.headline;
	static const textColorSecondary = ColorConstants.content;

//	<!--Char List items-->
	static const backgroundDarker = Color(0xFF41dfdcca);
	static const bio_titles_fontColor = Color(0xFF315e50);
	static const bio_shadow_color = Color(0xFFFFFFFF);
}

class MetalTheme {
	static const colorPrimary = Color(0xFF546e7a);
	static const colorPrimaryDark = Color(0xFF29434e);
	static const colorAccent = Color(0xFF224339);
	static const windowBackground = ColorConstants.colorMetalBackground;
	static const colorBackground = ColorConstants.colorMetalBackground;
	static const colorDivider = Color(0xFF546e7a);
	static const textColor = ColorConstants.text_color;
	static const textColorPrimary = ColorConstants.headline;
	static const textColorSecondary = ColorConstants.content;

//	<!--Char List items-->
	static const backgroundDarker = Color(0xFF5b7581);
	static const bio_titles_fontColor = ColorConstants.content;
	static const bio_shadow_color = Color(0xFFFFFF);
}

class DarkTheme {
	static const colorPrimary = ColorConstants.colorPrimary_2;
	static const colorPrimaryDark = ColorConstants.colorPrimaryDark_2;
	static const colorAccent = ColorConstants.colorAccent_2;
	static const windowBackground = ColorConstants.background_2;
	static const colorBackground = ColorConstants.background_2;
	static const textColor = Color(0xFFFFFF);
	static const textColorPrimary = ColorConstants.headline_2;
	static const textColorSecondary = ColorConstants.content_2;
	static const textColorHint = ColorConstants.hint_color;
	static const colorDivider = Color(0x253036);

//	<!--Char List items-->
	static const backgroundDarker = Color(0xFF303f46);
	static const bio_titles_fontColor = Color(0xFFFFFFFF);
	static const bio_shadow_color = Color(0xFF000000);
}

class OpaqueTheme {
	static const colorPrimary= ColorConstants.colorPrimary_3;
	static const colorPrimaryDark= ColorConstants.colorPrimaryDark_3;
	static const colorAccent= ColorConstants.colorAccent_3;
	static const textColorPrimary= ColorConstants.headline_3;
	static const textColorSecondary= ColorConstants.content_3;
	static const colorDivider = Color(0xFF7b880e4f);

//	<!--Char List items-->
	static const backgroundDarker = Color(0xFFe17fab);
	static const bio_titles_fontColor = Color(0xFFFFFFFF);
	static const bio_shadow_color = Color(0xFF000000);
}

class AutumnTheme {
	static const colorPrimary= ColorConstants.colorPrimary_4;
	static const colorPrimaryDark= ColorConstants.headline_4;
	static const colorAccent= ColorConstants.colorAccent_4;
	static const textColorPrimary= ColorConstants.headline_4;
	static const colorBackground= ColorConstants.background_4;
	static const colorDivider = Color(0xFFd67748);

//	<!--Char List items-->
	static const backgroundDarker = Color(0xFFd67748);
	static const bio_titles_fontColor = Color(0xFFFFFFFF);
	static const bio_shadow_color = Color(0xFF000000);
}

class WhiteTheme {
	static const colorPrimary = Color(0xFF000000);
	static const colorPrimaryDark = Color(0xFF000000);
	static const colorAccent = Color(0xFFFF9800);
	static const colorBackground = Color(0xFFFFFFFF);
	static const textColorPrimary = Color(0xFF000000);
	static const textColorSecondary= ColorConstants.content_3;
	static const colorDivider = Color(0xFF383838);

//	<!--Char List items-->
	static const backgroundDarker = Color(0xFF000000);
	static const bio_titles_fontColor = Color(0xFF000000);
	static const bio_shadow_color = Color(0xFFFFFFFF);
}

class AlertDialogTheme {
	static const colorPrimary = Color(0xFFFFFF);
	static const colorAccent = Color(0xFFFFFF);
	static const colorBackground = Color(0xFF29434e);
	static const textColor = Color(0xFF3bc13d);
	static const textColorPrimary = Color(0xFFFFFF);
}

class NegativeButtonStyle {
	static const textColor = Color(0xFFFF0000);
}

class PositiveButtonStyle {
	static const textColor = Color(0xFF3bc13d);
}