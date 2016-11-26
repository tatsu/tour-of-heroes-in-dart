import 'dart:async';
import 'package:angular2/core.dart';

import 'hero.dart';
import 'hero_detail/hero_detail_component.dart';
import 'service/hero_service.dart';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [HeroDetailComponent],
    providers: const [HeroService])
class AppComponent implements OnInit {
  final String title = 'Tour of Heroes';
  List<Hero> heroes;
  Hero selectedHero;

  final HeroService _heroService;

  AppComponent(this._heroService);

  @override
  ngOnInit() {
    getHeroes();
  }

  Future<Null> getHeroes() async {
    heroes = await _heroService.getHeroes();
  }

  onSelect(Hero hero) {
    selectedHero = hero;
  }
}
