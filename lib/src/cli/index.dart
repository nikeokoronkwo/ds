
import 'package:args/command_runner.dart';
import 'package:ds/src/cli/build.dart';

Future run(List<String> args) async {
  try {
    return await CommandRunner('ds', 'Unknown Server Framework...')
    ..addCommand(BuildCommand())
    ..run(args);
  } on UsageException catch (error) {
    print(error);
    rethrow;
  }
}