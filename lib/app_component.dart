import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dart_tour_of_heroes/dashboard/dashboard_component.dart';
import 'package:dart_tour_of_heroes/hero_detail/hero_detail_component.dart';
import 'package:dart_tour_of_heroes/heroes/heroes_component.dart';
import 'package:dart_tour_of_heroes/service/hero_service.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    styleUrls: const ['app_component.css'],
    directives: const [ROUTER_DIRECTIVES],
    providers: const [HeroService, ROUTER_PROVIDERS]
)
@RouteConfig(const [
  const Route(
      path: '/dashboard',
      name: 'Dashboard',
      component: DashboardComponent,
      useAsDefault: true),
  const Route(
      path: '/heroes',
      name: 'Heroes',
      component: HeroesComponent),
  const Route(
      path: '/detail/:id',
      name: 'HeroDetail',
      component: HeroDetailComponent)
])
class AppComponent {
  final String title = 'Tour of Heroes';
}
