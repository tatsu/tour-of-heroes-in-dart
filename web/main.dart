import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';

import 'package:http/http.dart';

import 'package:dart_tour_of_heroes/service/in_memory_data_service.dart';
import 'package:dart_tour_of_heroes/app_component.dart';

main() {
  bootstrap(AppComponent, [
    provide(Client, useClass: InMemoryDataService)
    // Using a real back end? Import browser_client.dart and change the above to
    // provide(BrowserClient, useFactory: () => new BrowserClient(), deps: [])
  ]);
}
