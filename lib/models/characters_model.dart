import 'package:rickandmorty/models/info_model.dart';

class CharactersModel {
  InfoModel info;
  final List<CharacterModel> characters;

  CharactersModel({required this.info, required this.characters});

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    final info = InfoModel.fromMap(json['info']);
    final characters = (json['results'] as List)
        .map((characterJson) => CharacterModel.fromJson(characterJson))
        .toList();

    return CharactersModel(info: info, characters: characters);
  }
}

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Location location;
  final Origin origin;
  final List<String> episode;

  CharacterModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.gender,
      required this.image,
      required this.location,
      required this.origin,
      required this.episode});

  CharacterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        status = json['status'],
        species = json['species'],
        gender = json['gender'],
        image = json['image'],
        location = Location.fromJson(json['location']),
        origin = Origin.fromJson(json['origin']),
        episode = List<String>.from(json['episode']);
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];
}

class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  Origin.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];
}
