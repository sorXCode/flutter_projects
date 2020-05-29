class Repo {
  String name;
  String owner;

  Repo.fromJson(json) {
    name = json['name'];
    owner = json['owner']['login'];
  }
}
