class PersonImages {
  String profileImg;
  int height;
  int width;

  PersonImages({this.profileImg, this.height, this.width});

  PersonImages.fromJson(Map<String, dynamic> json)
      : profileImg = json["file_path"],
        height = json["height"],
        width = json["width"];
}
