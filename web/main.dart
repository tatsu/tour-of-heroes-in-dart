import 'package:angular2/platform/browser.dart';
import 'package:firebase/firebase.dart' as firebase;

import 'package:dart_tour_of_heroes/app_component.dart';

main() {
  firebase.initializeApp(
      apiKey: "YourApiKey",
      authDomain: "YourApiKey",
      databaseURL: "YourDatabaseUrl",
      storageBucket: "YourStorageBucket");

  bootstrap(AppComponent);
}
