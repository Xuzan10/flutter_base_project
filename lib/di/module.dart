import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mcn_app/api/api_service.dart';

import 'module.config.dart';

final GetIt g = GetIt.instance;

@injectableInit
Future<void> configureInjection() async => $initGetIt(g);
