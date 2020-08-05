class User extends Object{
	String uid;
	String name;
	String email;
	String uriString;
	String picUri;


	User({String uid, String name, String email, String uriString, String picUri}) {
		this.uid = uid;
		this.name = name;
		this.email = email;
		this.uriString = uriString;
		this.picUri = picUri;
	}

	Map<String, dynamic> toMap() {
		return {
			'uid': uid,
			'name' : name,
			'email' : email,
			'picUrl' : picUri,
			'uriString' : uriString
		};
	}
}