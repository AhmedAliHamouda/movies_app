import 'person.dart';
class PersonResponse {
  List<Person> persons;
  String error;

  PersonResponse({this.persons, this.error});

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons =
  (json["results"] as List).map((i) => new Person.fromJson(i)).toList(),
        error = "";

  PersonResponse.withError(String errorValue)
      : persons = List(),
        error = errorValue;
}