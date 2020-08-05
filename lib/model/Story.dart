import 'dart:core';
import 'package:plotgenerator/model/Comment.dart';
import 'package:plotgenerator/model/user.dart';

class Story extends Object {
	String id;
	String title;
	String genre;
	String challenge;
	int date;
	Map<String, dynamic> user;
	String story;
	String language;
	int viewCount;
	bool published;
	int likeCount;
	Map<String, dynamic>  likesMap;

	Story({String id, String title, String genre, String challenge, int date, Map<String, dynamic> user , String story, String language, int viewCount, bool published, int likeCount, Map<String, dynamic> likesMap}) {
		this.id = id;
		this.title = title;
		this.genre = genre;
		this.challenge = challenge;
		this.date = date;
		this.user = user;
		this.story = story;
		this.viewCount = viewCount;
		this.published = published;
		this.language = language;
		this.likeCount = likeCount;
		this.likesMap = likesMap;
	}

	Map<String, dynamic> toMap() {
		return {
			'id': id,
			'user': user,
			'title': title,
			'genre': genre,
			'chalenge':challenge,
			'date': date,
			'likeCount': likeCount,
			'viewCount': viewCount,
			'published': published,
			'language': language,
			'likes' : likesMap,
			'story' : story
		};
	}

	static Story fromMap(Map<String, dynamic> map) {
		return Story(
			id: map['id'],
			user: map['user'],
			title: map['title'],
			genre: map['gender'],
			challenge: map['chalenge'],
			date: map['date'],
			likeCount: map['likeCount'],
			viewCount:map['viewCount'],
			published:map['published'],
			language:map['language'],
			likesMap:map['likes'],
		);
	}
}