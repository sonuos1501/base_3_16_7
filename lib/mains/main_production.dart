import '../configs/env/env_state.dart';
import 'setup.dart';

Future<void> main(List<String> args) async {
  await setUpAndRunApp(env: EnvValue.production);
}
