class PersonDetail {
int id;
double popularity;
String name;
String profileImg;
String known;
String biography;
String birthday;
String deathDay;
String placeOfBirth;


PersonDetail({this.id, this.popularity, this.name, this.profileImg, this.known,this.biography,this.birthday,this.placeOfBirth,this.deathDay});

PersonDetail.fromJson(Map<String, dynamic> json)
: id = json["id"],
popularity = json["popularity"],
name = json["name"],
profileImg = json["profile_path"],
known = json["known_for_department"],
biography=json["biography"],
birthday=json["birthday"],
placeOfBirth=json["place_of_birth"],
deathDay=json["deathday"];

}