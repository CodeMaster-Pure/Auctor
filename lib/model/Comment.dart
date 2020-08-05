class Comment{
	String userId;
	String userName;
	String userPic;
	String userComment;
	int userDate;


	Comment({String userId = '', String userName= '', String userPic='', String userComment='', int userDate}) {
		this.userId = userId;
		this.userName = userName;
		this.userPic = userPic;
		this.userComment = userComment;
		this.userDate = userDate;
	}

	Map<String, dynamic> toMap() {
		return {
			'userId': userId,
			'userName' : userName,
			'userComment' : userComment,
			'userPic' : userPic,
			'userDate' : userDate
		};
	}
}