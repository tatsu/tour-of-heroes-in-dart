import 'dart:async';
import 'dart:math';
import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as firebase;

import 'package:dart_tour_of_heroes/hero.dart';

@Injectable()
class HeroService {
  firebase.Database _fbDatabase;
  firebase.DatabaseReference _fbRefHeroes;
  List<Hero> _heroes;
  int _idMax;

  HeroService() {
    _fbDatabase = firebase.database();
    _fbRefHeroes = _fbDatabase.ref("app/heroes");
  }

  Future<Hero> getHero(int id) async =>
      (await getHeroes()).firstWhere((hero) => hero.id == id);

  Future<List<Hero>> getHeroes() async {
    try {
      final List<Hero> heroes = [];
      _idMax = 0;

      var e = await _fbRefHeroes.onValue.first;
      e.snapshot.forEach((child) {
        Hero hero = new Hero.fromJson(child.val());
        heroes.add(hero);
        _idMax = max(hero.id, _idMax);
      });

      _heroes = heroes;

      /*
      // Listening for updates
      _fbRefHeroes.onChildAdded.listen((e) {
        Hero hero = new Hero.fromJson(e.snapshot.val());
        _heroes.add(hero);
      });
      _fbRefHeroes.onChildRemoved.listen((e) {
        Hero hero = new Hero.fromJson(e.snapshot.val());
        _heroes.remove(_heroes.firstWhere((h) => h.id == hero.id));
      });
      _fbRefHeroes.onChildChanged.listen((e) {
        Hero hero = new Hero.fromJson(e.snapshot.val());
        _heroes
            .firstWhere((h) => h.id == hero.id)
            .name = hero.name;
      });
      */
    } catch (e) {
      throw _handleError(e);
    }

    return new List<Hero>.from(_heroes);
  }

  Future<Hero> create(String name) async {
    try {
      Hero hero = new Hero.fromJson({'id': ++_idMax, 'name': name});
      await _fbRefHeroes.push(hero.toJson());
      return hero;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> update(Hero hero) async {
    try {
      var e = await _fbRefHeroes.orderByChild('id').equalTo(hero.id).onValue.first;
      e.snapshot.forEach((child) {
        child.ref.update(hero.toJson());
      });
      return hero;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> delete(int id) async {
    try {
      var e = await _fbRefHeroes.orderByChild('id').equalTo(id).onValue.first;
      e.snapshot.forEach((child) {
        child.ref.remove();
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }
}
