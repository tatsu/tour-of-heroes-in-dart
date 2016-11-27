import 'dart:async';
import 'package:angular2/core.dart';

import 'package:dart_tour_of_heroes/hero.dart';
import 'package:dart_tour_of_heroes/service/mock_heroes.dart';

@Injectable()
class HeroService {
  Future<Hero> getHero(int id) async =>
      (await getHeroes()).firstWhere((hero) => hero.id == id);

  Future<List<Hero>> getHeroes() async => mockHeroes;
}
