import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dart_tour_of_heroes/hero.dart';
import 'package:dart_tour_of_heroes/hero_detail/hero_detail_component.dart';
import 'package:dart_tour_of_heroes/service/hero_service.dart';

@Component(
    selector: 'my-heroes',
    templateUrl: 'heroes_component.html',
    styleUrls: const ['heroes_component.css'],
    directives: const [HeroDetailComponent]
)
class HeroesComponent {
  List<Hero> get heroes => _heroService.heroes;
  Hero selectedHero;

  final HeroService _heroService;
  final Router _router;

  HeroesComponent(this._heroService, this._router);
  
  Future<Null> add(String name) async {
    name = name.trim();
    if (name.isEmpty) return;
    await _heroService.create(name);
    selectedHero = null;
  }

  Future<Null> delete(Hero hero) async {
    await _heroService.delete(hero.id);
    if (selectedHero == hero) selectedHero = null;
  }

  Future<Null> gotoDetail() => _router.navigate([
    'HeroDetail',
    {'id': selectedHero.id.toString()}
  ]);

  onSelect(Hero hero) {
    selectedHero = hero;
  }
}
