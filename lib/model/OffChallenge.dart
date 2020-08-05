class OffChallengeKey {
	static const String TABLE_CHALLENGE = "challenges";
	static const String CHALLENGE_ID = "challengeID";
	static const String CHALLENGE_CHAR_ID = "characterID";
	static const String CHALLENGE_Q1 = "q1";
	static const String CHALLENGE_Q2 = "q2";
	static const String CHALLENGE_Q3 = "q3";
	static const String CHALLENGE_Q4 = "q4";
}

class OffChallenge extends Object {
	String challengeID;
	String characterID;
	String q1;
	String q2;
	String q3;
	String q4;

	static OffChallenge fromMap(Map<String, dynamic> map) {
		return OffChallenge(
			challengeID: map[OffChallengeKey.CHALLENGE_ID],
			characterID: map[OffChallengeKey.CHALLENGE_CHAR_ID],
			q1: map[OffChallengeKey.CHALLENGE_Q1],
			q2: map[OffChallengeKey.CHALLENGE_Q2],
			q3: map[OffChallengeKey.CHALLENGE_Q3],
			q4: map[OffChallengeKey.CHALLENGE_Q4]
		);
	}

	Map<String, dynamic> toMap() {
		return {
			OffChallengeKey.CHALLENGE_ID: challengeID,
			OffChallengeKey.CHALLENGE_CHAR_ID: characterID,
			OffChallengeKey.CHALLENGE_Q1: q1,
			OffChallengeKey.CHALLENGE_Q2: q2,
			OffChallengeKey.CHALLENGE_Q3: q3,
			OffChallengeKey.CHALLENGE_Q4: q4
		};
	}

	OffChallenge({int id = 0, String challengeID='', String characterID = "", String q1 = "", String q2 = "", String q3 = "", String q4 = ""}) {
		this.challengeID = challengeID;
		this.characterID = characterID;
		this.q3 = q3;
		this.q1 = q1;
		this.q2 = q2;
		this.q4 = q4;
	}
}