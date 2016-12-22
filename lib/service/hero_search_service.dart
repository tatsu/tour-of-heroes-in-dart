import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as firebase;

import 'package:dart_tour_of_heroes/hero.dart';

@Injectable()
class HeroSearchService {
  firebase.Database _fbDatabase;
  firebase.DatabaseReference _fbRefHeroes;

  HeroSearchService() {
    _fbDatabase = firebase.database();
    _fbRefHeroes = _fbDatabase.ref("app/heroes");
  }

  Future<List<Hero>> search(String term) async {
    final regExp = new RegExp(term, caseSensitive: false);

    try {
      final List<Hero> heroes = [];

      var e = await _fbRefHeroes.onValue.first;
      await e.snapshot.forEach((child) {
        Hero hero = new Hero.fromJson(child.val());
        if (hero.name.contains(regExp)) {
          heroes.add(hero);
        }
      });

      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }
}
