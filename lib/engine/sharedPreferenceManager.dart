import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
	static Future<bool> checkFirstTime() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		int first_time = prefs.getInt('first_time') ?? 0;

		if (first_time == 0 ) {
			prefs.setInt('first_time', 1);
			return true;
		} else {
			return false;
		}
	}



	static Future<void> saveOnSharePreg(String key, String value) async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.setString(key, value);
	}

	static Future<void> saveOnSharePregInt(String key, int value) async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.setInt(key, value);
	}

	static Future<int> getSharePref(String key, int value) async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		int result = prefs.getInt(key) ?? value;
		return result;
	}

	static Future<String> getStringSharePref (String key) async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		String result = prefs.getString(key) ?? '';

		return result;
	}



}