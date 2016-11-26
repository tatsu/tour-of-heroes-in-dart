import 'package:angular2/core.dart';

import '../hero.dart';

@Component(
    selector: 'my-hero-detail',
    styleUrls: const ['hero_detail_component.css'],
    templateUrl: 'hero_detail_component.html')
class HeroDetailComponent {
  @Input()
  Hero hero;
}
