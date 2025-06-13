import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkModel extends ChangeNotifier {
  static const _key = 'favorites';
  final SharedPreferences _prefs;
  final Set<int> _favorites;

  BookmarkModel(this._prefs)
      : _favorites = (_prefs.getStringList(_key) ?? []).map(int.parse).toSet();

  static Future<SharedPreferences> initPrefs() => SharedPreferences.getInstance();

  bool isFavorite(int id) => _favorites.contains(id);

  void toggleFavorite(int id) {
    if (_favorites.contains(id)) _favorites.remove(id);
    else _favorites.add(id);
    _prefs.setStringList(_key, _favorites.map((i) => i.toString()).toList());
    notifyListeners();
  }
}