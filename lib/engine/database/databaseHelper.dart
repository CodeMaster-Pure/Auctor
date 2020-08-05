import 'package:path/path.dart';
import 'package:plotgenerator/model/OffChallenge.dart';
import 'package:plotgenerator/model/Character.dart';
import 'package:plotgenerator/model/Outline.dart';
import 'package:plotgenerator/model/OffStory.dart';
import 'package:plotgenerator/model/Project.dart';
import 'package:plotgenerator/model/Timeline.dart';
import 'package:sqflite/sqflite.dart';

typedef DatabaseHelperAddListener = Function(Object result, String error);
typedef DatabaseHelperFetchListener = Function(List<Object> results, String error);
class DatabaseHelper {
	static const DATABASE_NAME = "production_database";
	static final DatabaseHelper sharedInstance = DatabaseHelper._internal();
	DatabaseHelper._internal();
	factory DatabaseHelper() {
		return sharedInstance;
	}

	Database _database;
	Future<Database> get database async {
		if (_database != null) { return _database; }
		return await openDatabase(join(await getDatabasesPath(), DATABASE_NAME),
			version: 1,
			onCreate: _createTables);
	}

	_createTables(Database database, int version) {
		database.execute("CREATE TABLE " + ProjectKey.TableName + " (" +
			ProjectKey.Id + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
			ProjectKey.Name + " TEXT, " +
			ProjectKey.Genre + " TEXT, " +
			ProjectKey.Plot + " TEXT, " +
			ProjectKey.Image + " TEXT" +
			")");
		
		database.execute("CREATE TABLE " + CharacterKey.CHARACTER_TABLE_CHARACTER + " (" +
			CharacterKey.CHARACTER_COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
			CharacterKey.CHARACTER_COLUMN_PROJECT + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_NAME + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_NICKNAME + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_AGE + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_GENDER + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_DESIRE + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_ROLE + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_DEFMOMENT + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_NEED + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_PLACEBIRTH + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_TRAIT1 + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_TRAIT2 + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_TRAIT3 + " TEXT, " +
			CharacterKey.CHAR_EIR + " TEXT, " +
			CharacterKey.CHAR_EWR + " TEXT, " +
			CharacterKey.CHAR_EHP + " TEXT, " +
			CharacterKey.CHAR_EEF + " TEXT, " +
			CharacterKey.CHAR_ENOTES + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_JOB + " TEXT," +
			CharacterKey.CHARACTER_COLUMN_HEIGHT + " TEXT," +
			CharacterKey.CHARACTER_COLUMN_HAIRCOLOR + " TEXT," +
			CharacterKey.CHARACTER_COLUMN_EYECOLOR + " TEXT," +
			CharacterKey.CHARACTER_COLUMN_BODYBUILD + " TEXT," +
			CharacterKey.CHARACTER_COLUMN_BIRTHDATE + " TEXT," +
			CharacterKey.CHARACTER_COLUMN_PROJECT_ID + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_PHRASE + " TEXT, " +
			CharacterKey.CHARACTER_COLUMN_IMAGE + " TEXT, " +
			CharacterKey.CHAR_challengesCompleted + " INTEGER " +
			")");

		database.execute("CREATE TABLE " + OffStoryKey.CHARACTER_TABLE_STORY + " (" +
			OffStoryKey.STORY_COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
			OffStoryKey.STORY_COLUMN_PROJECT + " TEXT, " +
			OffStoryKey.STORY_COLUMN_PROJECT_ID + " TEXT, " +
			OffStoryKey.STORY_COLUMN_STORIES + " TEXT " +
			")");
		
		database.execute("CREATE TABLE " + OutlineKey.TABLE_OUTLINE + " (" +
			OutlineKey.OUTLINE_COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
			OutlineKey.OUTLINE_COLUMN_NAME + " TEXT, " +
			OutlineKey.OUTLINE_COLUMN_DESCRIPTION + " TEXT, " +
			OutlineKey.OUTLINE_COLUMN_PROJECT_ID + " TEXT, " +
			OutlineKey.OUTLINE_COLUMN_POSITION + " TEXT, " +
			OutlineKey.OUTLINE_COLUMN_CHARACTERS + " TEXT " +
			")");

		database.execute(
			"CREATE TABLE " + TimelineKey.TABLE_TIMELINE + " (" +
				TimelineKey.TIMELINE_COLUMN_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
				TimelineKey.TIMELINE_COLUMN_TITLE + " TEXT, " +
				TimelineKey.TIMELINE_COLUMN_DESCRIPTION + " TEXT, " +
				TimelineKey.TIMELINE_COLUMN_CHARACTER_ID + " TEXT, " +
				TimelineKey.TIMELINE_COLUMN_POSITION + " TEXT, " +
				TimelineKey.TIMELINE_COLUMN_DATE + " TEXT " +
				")"
		);

		database.execute(
			"CREATE TABLE " + OffChallengeKey.TABLE_CHALLENGE + " (" +
				OffChallengeKey.CHALLENGE_ID + " TEXT, " +
				OffChallengeKey.CHALLENGE_CHAR_ID + " TEXT, " +
				OffChallengeKey.CHALLENGE_Q1 + " TEXT, " +
				OffChallengeKey.CHALLENGE_Q2 + " TEXT, " +
				OffChallengeKey.CHALLENGE_Q3 + " TEXT, " +
				OffChallengeKey.CHALLENGE_Q4 + " TEXT " +
				")"
		);
		
		print('Database create!');
	}

	List<Project> _allProjects = [];
	Future<List<Project>> get allProjects async {
		Database db = await DatabaseHelper.sharedInstance.database;
		List<Map<String, dynamic>> results = await db.query(ProjectKey.TableName);
		_allProjects = List.generate(results.length, (index) => Project.fromMap(results[index]));

		return _allProjects;
	}

	List<Character> currentCharacter = [];
	Future<List<Character>> getCharacterByProjectID(String project_id) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		List<dynamic> whereArguments = [project_id];
		List<Map<String, dynamic>> results = await db.query(
			CharacterKey.CHARACTER_TABLE_CHARACTER,
			where: '${CharacterKey.CHARACTER_COLUMN_PROJECT_ID} = ?',
			whereArgs: whereArguments
		);
		currentCharacter = List.generate(results.length, (index) => Character.fromMap(results[index]));

		return currentCharacter;
	}
	
	Future<Character> getCharacterByID(int character_id) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		List<Map> results = await db.query(CharacterKey.CHARACTER_TABLE_CHARACTER,
			columns: [CharacterKey.CHAR_challengesCompleted],
			where: '_id = ?',
			whereArgs: [character_id]);
		
		if (results.length > 0) {
			return Character.fromMap(results.first);
		}
		
		return null;
	}

	List<Outline> currentOutlines = [];
	Future<List<Outline>> getOutlineByProjectID(String project_id) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		List<dynamic> whereArguments = [project_id];
		List<Map<String, dynamic>> results = await db.query(
			OutlineKey.TABLE_OUTLINE,
			where: '${OutlineKey.OUTLINE_COLUMN_PROJECT_ID} = ?',
			whereArgs: whereArguments
		);
		currentOutlines = List.generate(results.length, (index) => Outline.fromMap(results[index]));
		
		return currentOutlines;
	}

	Project currentProject;
	Future<int> createProject(Project project) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.insert(ProjectKey.TableName, project.toMap());
	}
	
	Future<int> createCharacter(Character character) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.insert( CharacterKey.CHARACTER_TABLE_CHARACTER, character.toMap());
	}

	Future<int> deleteProjectFromSQL(int project_id) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		await db.delete(ProjectKey.TableName, where: '_id = ?', whereArgs: [project_id]).then((result) async{
			if (result == 1){
				await db.delete(CharacterKey.CHARACTER_TABLE_CHARACTER, where: 'project_id = ?', whereArgs: [project_id]).then((result){
					return result;
				});
			}
		});
	}

	Future<int> countAllCharacters() async {
		Database db = await DatabaseHelper.sharedInstance.database;
		var result = await db.query(CharacterKey.CHARACTER_TABLE_CHARACTER);
		return result.length;
	}

	Future<int> countCharacterByProjectID(int project_id) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		var result = await db.query(CharacterKey.CHARACTER_TABLE_CHARACTER, where: 'project_id = ?', whereArgs: [project_id]);
		if ( result == null )
			return 0;
		return result.length;
	}

	Future<int> updateProject(Project project) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.update(ProjectKey.TableName, project.toMap(), where: "_id = ?", whereArgs: [project.id]);
	}

	Future<int> updateCharacter(Character character) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.update(CharacterKey.CHARACTER_TABLE_CHARACTER, character.toMap(), where: "_id = ?", whereArgs: [character.id]);
	}

	Future<int> deleteCharacaterByid(int characterID) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.delete(CharacterKey.CHARACTER_TABLE_CHARACTER, where: '_id = ?', whereArgs: [characterID]);
	}

	Future<int> createOutline(Outline outline) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.insert(OutlineKey.TABLE_OUTLINE, outline.toMap());
	}

	Future<int> deleteOutlineByid(int outlineID) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.delete(OutlineKey.TABLE_OUTLINE, where: '_id = ?', whereArgs: [outlineID]);
	}

	List<OffChallenge> challengesList = [];
	Future<List<OffChallenge>> getChallengesByID (String characterID) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		List<dynamic> whereArguments = [characterID];
		List<Map<String, dynamic>> results = await db.query(
			OffChallengeKey.TABLE_CHALLENGE,
			where: '${OffChallengeKey.CHALLENGE_CHAR_ID} = ?',
			whereArgs: whereArguments
		);
		challengesList = List.generate(results.length, (index) => OffChallenge.fromMap(results[index]));

		return challengesList;
	}

	Future<int> createOffChallenge(OffChallenge offChallenge) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.insert(OffChallengeKey.TABLE_CHALLENGE, offChallenge.toMap());
	}

	List<Timeline> timeLineLists = [];
	Future<List<Timeline>> getTimeLinesByID (String characterID) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		List<dynamic> whereArguments = [characterID];
		List<Map<String, dynamic>> results = await db.query(
			TimelineKey.TABLE_TIMELINE,
			where: '${TimelineKey.TIMELINE_COLUMN_CHARACTER_ID} = ?',
			whereArgs: whereArguments,
			orderBy: 'date ASC'
		);
		timeLineLists = List.generate(results.length, (index) => Timeline.fromMap(results[index]));

		return timeLineLists;
	}

	Future<int> createTimeline(Timeline timeLine) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.insert(TimelineKey.TABLE_TIMELINE, timeLine.toMap());
	}

	Future<int> updateTimeline(Timeline timeLine) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.update(TimelineKey.TABLE_TIMELINE, timeLine.toMap(), where: "_id = ?", whereArgs: [timeLine.id]);
	}

	Future<int> deleteTimeLineByid(int timelineID) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.delete(TimelineKey.TABLE_TIMELINE, where: '_id = ?', whereArgs: [timelineID]);
	}

	Future<int> createOffLineStory(OffStory offStory) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.insert(OffStoryKey.CHARACTER_TABLE_STORY, offStory.toMap());
	}

	Future<int> updateOfflineStory(OffStory offStory) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.update(OffStoryKey.CHARACTER_TABLE_STORY, offStory.toMap(), where: "_id = ?", whereArgs: [offStory.id]);
	}

	Future<OffStory> getOfflineStory(int id) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		var results = await db.rawQuery('SELECT * FROM story WHERE _id = $id');

		if (results.length > 0) {
			return new OffStory().fromMap(results.first);
		}
		return null;
	}

	Future<int> updateOutline(Outline outline) async {
		Database db = await DatabaseHelper.sharedInstance.database;
		return await db.update(OutlineKey.TABLE_OUTLINE, outline.toMap(), where: "_id = ?", whereArgs: [outline.id]);
	}
}