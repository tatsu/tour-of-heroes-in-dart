import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:stream_transformers/stream_transformers.dart';

import 'package:dart_tour_of_heroes/hero.dart';
import 'package:dart_tour_of_heroes/service/hero_search_service.dart';

@Component(
    selector: 'hero-search',
    templateUrl: 'hero_search_component.html',
    styleUrls: const ['hero_search_component.css'],
    providers: const [HeroSearchService])
class HeroSearchComponent implements OnInit {
  Stream<List<Hero>> heroes;
  StreamController<String> _searchTerms =
      new StreamController<String>.broadcast();

  final HeroSearchService _heroSearchService;
  final Router _router;

  HeroSearchComponent(this._heroSearchService, this._router);

  // Push a search term into the stream.
  void search(String term) => _searchTerms.add(term);

  @override
  Future<Null> ngOnInit() async {
    heroes = _searchTerms.stream
        .transform(new Debounce(new Duration(milliseconds: 300)))
        .distinct()
        .transform(new FlatMapLatest((term) => term.isEmpty
            ? new Stream<List<Hero>>.fromIterable([<Hero>[]])
            : new Future<List<Hero>>.sync(() => _heroSearchService.search(term))
                .asStream()))
        .handleError((e) {
      print(e); // for demo purposes only
    });
  }

  void gotoDetail(Hero hero) {
    var link = [
      'HeroDetail',
      {'id': hero.id.toString()}
    ];
    _router.navigate(link);
  }
}
