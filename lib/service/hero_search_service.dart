import 'dart:async';

import 'package:angular2/core.dart';
import 'package:dart_tour_of_heroes/service/hero_service.dart';
import 'package:firebase/firebase.dart' as firebase;

import 'package:dart_tour_of_heroes/hero.dart';

@Injectable()
class HeroSearchService {
  final HeroService _heroService;

  HeroSearchService(@Inject(HeroService) this._heroService);

  Future<List<Hero>> search(String term) async {
    final regExp = new RegExp(term, caseSensitive: false);

    List<Hero> heroes = await _heroService.getHeroes();
    return heroes.where((hero) => hero.name.contains(regExp)).toList();
  }
}
