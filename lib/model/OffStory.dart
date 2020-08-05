class OffStoryKey {
	static const CHARACTER_TABLE_STORY = "story";
	static const STORY_COLUMN_ID = "_id";
	static const STORY_COLUMN_PROJECT = "project";
	static const STORY_COLUMN_PROJECT_ID = "project_id";
	static const STORY_COLUMN_STORIES = "stories";
}

class OffStory extends Object {
	int id;
	String project_name;
	String project_id;
	String story;

	OffStory fromMap(Map<String, dynamic> map) {
		return OffStory(
			id: map[OffStoryKey.STORY_COLUMN_ID],
			project_id: map[OffStoryKey.STORY_COLUMN_PROJECT_ID],
			project_name: map[OffStoryKey.STORY_COLUMN_PROJECT],
			story: map[OffStoryKey.STORY_COLUMN_STORIES],
		);
	}

	Map<String, dynamic> toMap() {
		return {
			OffStoryKey.STORY_COLUMN_ID: id,
			OffStoryKey.STORY_COLUMN_PROJECT: project_name,
			OffStoryKey.STORY_COLUMN_PROJECT_ID: project_id,
			OffStoryKey.STORY_COLUMN_STORIES: story
		};
	}

	OffStory({int id = 0, String project_name = "", String project_id = "", String story = ""}) {
		this.id = id;
		this.project_name = project_name;
		this.project_id = project_id;
		this.story = story;
	}
}