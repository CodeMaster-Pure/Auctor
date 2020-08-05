class CharacterKey {
	static const CHARACTER_TABLE_CHARACTER = "character";
	static const CHARACTER_TABLE_STORY = "story";
	static const CHARACTER_COLUMN_NAME = "name";
	static const CHARACTER_COLUMN_ID = "_id";
	static const CHARACTER_COLUMN_PROJECT = "project";
	static const CHARACTER_COLUMN_PROJECT_ID = "project_id";
	static const CHARACTER_COLUMN_IMAGE = "image";
	static const CHARACTER_COLUMN_NICKNAME = "nickname";
	static const CHARACTER_COLUMN_AGE = "age";
	static const CHARACTER_COLUMN_GENDER = "gender";
	static const CHARACTER_COLUMN_DESIRE = "desire";
	static const CHARACTER_COLUMN_JOB = "profession";
	static const CHARACTER_COLUMN_HEIGHT = "height";
	static const CHARACTER_COLUMN_HAIRCOLOR = "haircolor";
	static const CHARACTER_COLUMN_EYECOLOR = "eyecolor";
	static const CHARACTER_COLUMN_BODYBUILD = "bodybuild";
	static const CHARACTER_COLUMN_BIRTHDATE = "birthdate";
	static const CHARACTER_COLUMN_ROLE = "role";
	static const CHARACTER_COLUMN_DEFMOMENT = "defmoment";
	static const CHARACTER_COLUMN_NEED = "need";
	static const CHARACTER_COLUMN_PLACEBIRTH = "placebirth";
	static const CHARACTER_COLUMN_PHRASE = "phrase";
	static const CHARACTER_COLUMN_TRAIT1 = "trait1";
	static const CHARACTER_COLUMN_TRAIT2 = "trait2";
	static const CHARACTER_COLUMN_TRAIT3 = "trait3";
	
	//Challenge I old naming.
	static const CHAR_EIR = "elevator_initial_reaction";
	static const CHAR_EWR = "elevator_wait_rescue";
	static const CHAR_EHP = "elevator_help_partner";
	static const CHAR_EEF = "elevator_escape_first";
	static const CHAR_ENOTES = "elevator_notes";
	//endregion
	static const CHAR_challengesCompleted = "challengesCompleted";

}

class Character extends Object {
	int id, challengesDone;
	String name, project_id, profession, height, hairColor, eyeColor, bodyBuild, desire, age, gender, role, defmoment, need, placeBirth, project, trait1, trait2, trait3, note, phrase, birthdate, image;

	static Character fromMap(Map<String, dynamic> map) {
		return Character(
			id: map['_id'],
			name: map['name'],
			role: map['role'],
			gender: map['gender'],
			challengesDone: map['challengesCompleted'],
			image: map['image'],
			age: map['age'],
			placeBirth:map['placebirth'],
			profession:map['profession'],
			height:map['height'],
			hairColor:map['haircolor'],
			eyeColor:map['eyecolor'],
			bodyBuild:map['bodybuild'],
			desire:map['desire'],
			defmoment:map['defmoment'],
			need:map['need'],
			phrase:map['phrase'],
			trait1:map['trait1'],
			trait2:map['trait2'],
			trait3:map['trait3'],
			note:map['elevator_notes'],
			birthdate: map['birthdate'],
		);
	}

	Map<String, dynamic> toMap() {
		return {
			CharacterKey.CHARACTER_COLUMN_NAME : name,
			CharacterKey.CHARACTER_COLUMN_PROJECT_ID : project_id,
			CharacterKey.CHARACTER_COLUMN_JOB: profession,
			CharacterKey.CHARACTER_COLUMN_HEIGHT: height,
			CharacterKey.CHARACTER_COLUMN_HAIRCOLOR: hairColor,
			CharacterKey.CHARACTER_COLUMN_EYECOLOR: eyeColor,
			CharacterKey.CHARACTER_COLUMN_BODYBUILD :bodyBuild,
			CharacterKey.CHARACTER_COLUMN_DESIRE: desire,
			CharacterKey.CHARACTER_COLUMN_AGE: age,
			CharacterKey.CHARACTER_COLUMN_GENDER: gender,
			CharacterKey.CHARACTER_COLUMN_ROLE:role,
			CharacterKey.CHARACTER_COLUMN_DEFMOMENT: defmoment,
			CharacterKey.CHARACTER_COLUMN_NEED: need,
			CharacterKey.CHARACTER_COLUMN_PLACEBIRTH: placeBirth,
			CharacterKey.CHARACTER_COLUMN_PROJECT: project,
			CharacterKey.CHARACTER_COLUMN_TRAIT1: trait1,
			CharacterKey.CHARACTER_COLUMN_TRAIT2: trait2,
			CharacterKey.CHARACTER_COLUMN_TRAIT3: trait3,
			CharacterKey.CHARACTER_COLUMN_PHRASE: phrase,
			CharacterKey.CHARACTER_COLUMN_IMAGE: image,
			CharacterKey.CHARACTER_COLUMN_BIRTHDATE: birthdate,
			CharacterKey.CHAR_challengesCompleted : challengesDone
		};
	}

	Character({int id, int challengesDone = 0, String name = "",String project_id = "",String profession= "",String height= "",String hairColor= "",String eyeColor= "",String bodyBuild= "",String desire= "",String age= "",String gender= "",String role= "",String defmoment= "",String need= "",String placeBirth= "",String project= "",String trait1= "",String trait2= "",String trait3= "",String note= "",String phrase= "",String image= "" , String birthdate = "", String challengeDoneString}) {
		this.id = id;
		this.challengesDone = challengesDone;
		this.name = name;
		this.project_id = project_id;
		this.profession = profession;
		this.height = height;
		this.hairColor = hairColor;
		this.eyeColor = eyeColor;
		this.bodyBuild = bodyBuild;
		this.desire = desire;
		this.age = age;
		this.gender = gender;
		this.role = role;
		this.defmoment = defmoment;
		this.need = need;
		this.placeBirth = placeBirth;
		this.project = project;
		this.trait1 = trait1;
		this.trait2 = trait2;
		this.trait3 = trait3;
		this.note = note;
		this.phrase = phrase;
		this.image = image;
		this.birthdate = birthdate;
	}
}