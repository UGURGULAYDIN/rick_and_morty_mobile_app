import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences prefs;

  PreferencesService({required this.prefs});

  final String _characterKey = 'characters';

  void storeCharacters(List<String> characters) async {
    await prefs.setStringList(_characterKey, characters);
  }

  void saveCharacter(int id) async {
    final characterList = prefs.getStringList(_characterKey) ?? [];
    characterList.add(id.toString());
    storeCharacters(characterList);
  }

  void removeCharacter(int id) async {
    final characterList = prefs.getStringList(_characterKey) ?? [];
    characterList.remove(id.toString());
    storeCharacters(characterList);
  }

  List<int> getSavedCharacters() {
    final characterList = prefs.getStringList(_characterKey) ?? [];
    return characterList.map((e) => int.parse(e)).toList();
  }
}
