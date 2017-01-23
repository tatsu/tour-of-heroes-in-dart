import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:dart_tour_of_heroes/hero.dart';
import 'package:dart_tour_of_heroes/service/hero_service.dart';


@Component(
    selector: 'my-hero-detail',
    templateUrl: 'hero_detail_component.html',
    styleUrls: const ['hero_detail_component.css']
)
class HeroDetailComponent implements OnInit {
  Hero hero;

  final HeroService _heroService;
  final RouteParams _routeParams;
  final Location _location;

  HeroDetailComponent(this._heroService, this._routeParams, this._location);

  @override
  Future<Null> ngOnInit() async {
    var id = _routeParams.get('id');
    assert(id != null);
    id = int.parse(id);
    hero = await _heroService.getHero(id);
  }

  void goBack() => _location.back();

  Future<Null> save() async {
    await _heroService.update(hero);
    goBack();
  }
}
