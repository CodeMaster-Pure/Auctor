import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plotgenerator/model/OffChallenge.dart';
import 'package:plotgenerator/model/Character.dart';
import 'package:plotgenerator/model/OffStory.dart';
import 'package:plotgenerator/model/Outline.dart';
import 'package:plotgenerator/model/Story.dart';
import 'package:plotgenerator/model/Timeline.dart';
import 'package:plotgenerator/model/user.dart';

import '../model/Project.dart';
import 'modelTemp.dart';

class Common {
	static User currentUser;
	static Story currentStory;
	static OffChallenge currentChallenge;
	static OffStory currentOfflineStory;
	static Character currentCharacter;
	static List<Character> currentCharacterLists;
	static Project currentProject;
	static Outline currentOutline;
	static String currentOutlineID;
	static Timeline currentTimeline;
	static bool currentLanguageEnglish;
	static ModelTemp currentModelTemp;
	static bool isPAU;
	static String currentGenre;
	static bool charCreationMode;
	static bool projectCreationMode;
	static bool outlineCreationMode;
	static bool timelineCreationMode;
	static String currentWeeklyStoryTitle;
	
	static String currentDeviceType;

	static int currentTheme;
	static int onBoarding;
	static bool tutorialMODE;
	static int projectCount;
	static int characterCount;
	static int commentCount;
	static Color containerBackColor;
	static Color storyDetailTextColor;
	static Color premiumTextColor;

	//Database references
	static CollectionReference currentQuery;
	static Firestore currentDatabase;
	static CollectionReference currentReference;
	static DocumentReference currentDocumentReference;
	static CollectionReference currentCommentReference;
	static CollectionReference currentUserReference;
	static FirebaseAuth currentAuth;
	static FirebaseUser currentFirebaseUser;

	static String characterProject() {
		if (currentCharacter != null ) {
			return currentCharacter.project;
		}

		return '';
	}

	static String characterID() {
		if( currentCharacter != null){
			return currentCharacter.id.toString();
		}

		return '';
	}
}