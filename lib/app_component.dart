// Copyright (c) 2016, tatsu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

class Hero {
  final int id;
  String name;

  Hero(this.id, this.name);
}

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html')
class AppComponent {
  String title = 'Tour of Heroes';
  Hero hero = new Hero(1, 'Windstorm');
}
