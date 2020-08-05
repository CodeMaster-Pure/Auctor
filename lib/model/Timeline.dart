import 'package:flutter/material.dart';

class TimelineKey {
	static const TABLE_TIMELINE = "timeline";
	static const TIMELINE_COLUMN_ID = "_id";
	static const TIMELINE_COLUMN_TITLE = "title";
	static const TIMELINE_COLUMN_DESCRIPTION = "description";
	static const TIMELINE_COLUMN_CHARACTER_ID = "character_id";
	static const TIMELINE_COLUMN_POSITION = "position";
	static const TIMELINE_COLUMN_DATE = "date";
}

class Timeline extends Object {
	int id;
	String title;
	String description;
	String character_id;
	String position;
	String date;

	static Timeline fromMap(Map<String, dynamic> map) {
		return Timeline(
			id: map[TimelineKey.TIMELINE_COLUMN_ID],
			title: map[TimelineKey.TIMELINE_COLUMN_TITLE],
			description: map[TimelineKey.TIMELINE_COLUMN_DESCRIPTION],
			character_id: map[TimelineKey.TIMELINE_COLUMN_CHARACTER_ID],
			position: map[TimelineKey.TIMELINE_COLUMN_POSITION],
			date: map[TimelineKey.TIMELINE_COLUMN_DATE],
		);
	}

	Map<String, dynamic> toMap() {
		return {
			TimelineKey.TIMELINE_COLUMN_ID: id,
			TimelineKey.TIMELINE_COLUMN_TITLE: title,
			TimelineKey.TIMELINE_COLUMN_DESCRIPTION: description,
			TimelineKey.TIMELINE_COLUMN_CHARACTER_ID: character_id,
			TimelineKey.TIMELINE_COLUMN_POSITION: position,
			TimelineKey.TIMELINE_COLUMN_DATE: date,
		};
	}

	Timeline({int id, String title = "", String description = "", String character_id = "", String position = "", String date = "", int sortIndex}) {
		this.id = id;
		this.title = title;
		this.position = position;
		this.description = description;
		this.character_id = character_id;
		this.date = date;
	}
}