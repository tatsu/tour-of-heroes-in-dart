import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dart_tour_of_heroes/hero.dart';
import 'package:dart_tour_of_heroes/service/hero_service.dart';

@Component(
    selector: 'my-heroes',
    templateUrl: 'heroes_component.html',
    styleUrls: const ['heroes_component.css']
)
class HeroesComponent implements OnInit {
  List<Hero> heroes;
  Hero selectedHero;

  final HeroService _heroService;
  final Router _router;

  HeroesComponent(this._heroService, this._router);

  @override
  ngOnInit() {
    getHeroes();
  }

  Future<Null> getHeroes() async {
    heroes = await _heroService.getHeroes();
  }

  Future<Null> gotoDetail() => _router.navigate([
    'HeroDetail',
    {'id': selectedHero.id.toString()}
  ]);

  onSelect(Hero hero) {
    selectedHero = hero;
  }
}
