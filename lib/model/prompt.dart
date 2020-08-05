import 'user.dart';

class Prompt {
	String id;
	int date;
	Map<String, dynamic> user;
	String story;
	bool selected;

	Prompt({String id, int date, Map<String, dynamic> user, String story, bool selected}) {
		this.id = id;
		this.date = date;
		this.user = user;
		this.story = story;
		this.selected= selected;
	}

	Map<String, dynamic> toMap() {
		return {
			'id': id,
			'user' : user,
			'date' : date,
			'story' : story,
			'selected' : selected
		};
	}
}