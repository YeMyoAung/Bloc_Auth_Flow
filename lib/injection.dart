import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:getx_auth_flow/repositories/AuthService.dart';

import 'firebase_options.dart';

final Injection = GetIt.instance;

Future<void> setup() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Injection.registerSingleton(
    AuthService(),
    dispose: (instance) => instance.dispose(),
  );
}
