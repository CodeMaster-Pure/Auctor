class ProjectKey {
	static const TableName = "projectname";
	static const Id = "_id";
	static const Name = "project";
	static const Genre = "genre";
	static const Plot = "plot";
	static const Image = "image";
}

class Project extends Object {
	int id;
	String name;
	String genre;
	String plot;
	String image;

	static Project fromMap(Map<String, dynamic> map) {
		return Project(
			id: map[ProjectKey.Id],
			name: map[ProjectKey.Name],
			genre: map[ProjectKey.Genre],
			plot: map[ProjectKey.Plot],
			image: map[ProjectKey.Image]
		);
	}

	Map<String, dynamic> toMap() {
		return {
			ProjectKey.Id: id,
			ProjectKey.Name: name,
			ProjectKey.Genre: genre,
			ProjectKey.Plot: plot,
			ProjectKey.Image: image
		};
	}

	Project({int id, String name = "", String genre = "", String plot = "", String image = ""}) {
		this.id = id;
		this.name = name;
		this.genre = genre;
		this.plot = plot;
		this.image = image;
	}
}