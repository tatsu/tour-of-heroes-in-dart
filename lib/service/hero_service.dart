import 'dart:async';
import 'dart:math';
import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as firebase;

import 'package:dart_tour_of_heroes/hero.dart';

@Injectable()
class HeroService {
  final firebase.DatabaseReference _heroesRef;
  final List<Hero> heroes = [];
  int _maxId = 0;

  HeroService() : _heroesRef = firebase.database().ref("app/heroes") {
    try {
      /*
      var e = await _fbRefHeroes.once('value');
      e.snapshot.forEach((child) {
        Hero hero = new Hero.fromJson(child.val());
        _heroes.add(hero);
        _idMax = max(hero.id, _idMax);
      });
      */

      // Listening for updates
      _heroesRef.onChildAdded.listen((e) {
        Hero hero = new Hero.fromJson(e.snapshot.val());
        _maxId = max(hero.id, _maxId);
        heroes.add(hero);
      });
      _heroesRef.onChildRemoved.listen((e) {
        Hero hero = new Hero.fromJson(e.snapshot.val());
        heroes.remove(heroes.firstWhere((h) => h.id == hero.id));
      });
      _heroesRef.onChildChanged.listen((e) {
        Hero hero = new Hero.fromJson(e.snapshot.val());
        heroes
            .firstWhere((h) => h.id == hero.id)
            .name = hero.name;
      });
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<Hero> getHero(int id) async {
    // It's possible the _heroes is not ready on the page load.
    final hero = heroes.firstWhere((hero) => hero.id == id, orElse: () => null);
    if (hero != null) {
      return new Future.value(hero);
    } else {
      // Try to fetch him from Firebase.
      // It might not the best design, while Firebase can be expected to handle a cached hero data effectively.
      // Should be added index on id later.
      final queryEvent = await _heroesRef.orderByChild('id').equalTo(id).once('value');
      final snapshot = queryEvent.snapshot.val();
      return new Hero.fromJson(snapshot.values.first);
    }
  }
  
  Future<Hero> create(String name) async {
    try {
      Hero hero = new Hero.fromJson({'id': ++_maxId, 'name': name});
      await _heroesRef.push(hero.toJson());
      return hero;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> update(Hero hero) async {
    try {
      var e = await _heroesRef.orderByChild('id').equalTo(hero.id).once('value');
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
      var e = await _heroesRef.orderByChild('id').equalTo(id).once('value');
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
