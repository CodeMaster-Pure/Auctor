import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/generated/i18n.dart';

import 'helper.dart';


class TutorialManager {
  static const isTutorialMode = true;

  static void check(BuildContext context) {
    switch (Common.onBoarding) {
      case 1: //First enter
        Helper.showTutorial(context, title: S.of(context).onBoardingTitle_1, message: S.of(context).onBoarding_1);
		Common.onBoarding++;
        break;
      case 2: //Project Detail first time
        Helper.showTutorial(context, title: S.of(context).onBoardingTitle_2, message: S.of(context).onBoarding_2);
		Common.onBoarding++;
        break;
      case 3: //Come back to ProjectList
        Helper.showTutorial(context, title: S.of(context).onBoardingTitle_3, message: S.of(context).onBoarding_3);
		Common.onBoarding++;
        break;
      case 4: //Go to Charlist
        Helper.showTutorial(context, title: S.of(context).onBoardingTitle_4, message: S.of(context).onBoarding_4);
		Common.onBoarding++;
        break;
      case 5: //Go to Create Character
        Helper.showTutorial(context, title: S.of(context).onBoardingTitle_5, message: S.of(context).onBoarding_5);
		Common.onBoarding++;
        break;
      case 6: //Come back to Charlist with a character
        Helper.showTutorial(context, title: S.of(context).onBoardingTitle_6, message: S.of(context).onBoarding_6);
		Common.onBoarding++;
        break;
      case 7: //Go to BIO
        Helper.showTutorial(context, title: S.of(context).onBoardingTitle_7, message: S.of(context).onBoarding_7);
		Common.onBoarding++;
        break;
    }
  }
}
