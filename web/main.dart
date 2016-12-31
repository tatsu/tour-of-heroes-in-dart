import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:firebase/firebase.dart' as firebase;

import 'package:dart_tour_of_heroes/app_component.dart';

main() {
  firebase.initializeApp(
      apiKey: "YourApiKey",
      authDomain: "YourApiKey",
      databaseURL: "YourDatabaseUrl",
      storageBucket: "YourStorageBucket");

  bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    provide(LocationStrategy, useClass: HashLocationStrategy)
  ]);
}
