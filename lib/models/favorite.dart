class FavoriteModel {
  int id;
  String name;
  String imageUrl;
  tojson() {
    return {"id": id, "name": name, "imageUrl": imageUrl};
  }

  FavoriteModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    imageUrl = map["imageUrl"];
  }
}
