import 'package:flutter/material.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

import 'views/my_app.dart';

Future<void> main() async {
  GetItDependenciesInjection().getItSetup();
  runApp(const MyApp());
}
