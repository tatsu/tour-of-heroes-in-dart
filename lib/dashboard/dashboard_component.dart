import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dart_tour_of_heroes/hero.dart';
import 'package:dart_tour_of_heroes/hero_search/hero_search_component.dart';
import 'package:dart_tour_of_heroes/service/hero_service.dart';

@Component(
    selector: 'my-dashboard',
    templateUrl: 'dashboard_component.html',
    styleUrls: const ['dashboard_component.css'],
    directives: const [HeroSearchComponent, ROUTER_DIRECTIVES])
class DashboardComponent {
  List<Hero> get heroes => _heroService.heroes.skip(1).take(4).toList();
  final HeroService _heroService;

  DashboardComponent(this._heroService);
}
