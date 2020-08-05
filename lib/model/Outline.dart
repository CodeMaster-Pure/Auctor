class OutlineKey {
	static const TABLE_OUTLINE = "outline";
	static const OUTLINE_COLUMN_ID = "_id";
	static const OUTLINE_COLUMN_NAME = "name";
	static const OUTLINE_COLUMN_DESCRIPTION = "description";
	static const OUTLINE_COLUMN_CHARACTERS = "charactersPresent";
	static const OUTLINE_COLUMN_PROJECT_ID = "project_id";
	static const OUTLINE_COLUMN_POSITION = "position";
}

class Outline extends Object {
	int id;
	String name;
	String description;
	String characterPresent;
	String project_id;
	String position;

	static Outline fromMap(Map<String, dynamic> map) {
		return Outline(
			id: map[OutlineKey.OUTLINE_COLUMN_ID],
			name: map[OutlineKey.OUTLINE_COLUMN_NAME],
			description: map[OutlineKey.OUTLINE_COLUMN_DESCRIPTION],
			characterPresent: map[OutlineKey.OUTLINE_COLUMN_CHARACTERS],
			project_id: map[OutlineKey.OUTLINE_COLUMN_PROJECT_ID],
			position: map[OutlineKey.OUTLINE_COLUMN_POSITION]
		);
	}

	Map<String, dynamic> toMap() {
		return {
			OutlineKey.OUTLINE_COLUMN_ID: id,
			OutlineKey.OUTLINE_COLUMN_NAME: name,
			OutlineKey.OUTLINE_COLUMN_DESCRIPTION: description,
			OutlineKey.OUTLINE_COLUMN_CHARACTERS: characterPresent,
			OutlineKey.OUTLINE_COLUMN_PROJECT_ID: project_id,
			OutlineKey.OUTLINE_COLUMN_POSITION: position
		};
	}

	Outline({int id, String name = "", String description = "", String characterPresent = "", String project_id = "", String position = ""}) {
		this.id = id;
		this.name = name;
		this.project_id = project_id;
		this.description = description;
		this.characterPresent = characterPresent;
		this.position = position;
	}
}