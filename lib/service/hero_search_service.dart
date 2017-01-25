import 'package:angular2/core.dart';
import 'package:dart_tour_of_heroes/service/hero_service.dart';
import 'package:dart_tour_of_heroes/hero.dart';

@Injectable()
class HeroSearchService {
  final HeroService _heroService;

  HeroSearchService(this._heroService);

  List<Hero> search(String term) {
    final regExp = new RegExp(term, caseSensitive: false);

    List<Hero> heroes = _heroService.heroes;
    return heroes.where((hero) => hero.name.contains(regExp)).toList();
  }
}
