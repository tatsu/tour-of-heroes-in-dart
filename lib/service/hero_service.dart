import 'dart:async';
import 'package:angular2/core.dart';

import '../hero.dart';
import 'mock_heroes.dart';

@Injectable()
class HeroService {
  Future<List<Hero>> getHeroes() async {
    // Simulate a slow connection
    return new Future.delayed(const Duration(seconds: 2),
        () => mockHeroes
    );
  }
}
