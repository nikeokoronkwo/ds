import 'package:args/command_runner.dart';

import 'task.dart';
import 'build.dart';
import 'dev.dart';

Future run(List<String> args) async {
  try {
    return await CommandRunner('ds', 'Unknown Server Framework...')
      ..addCommand(BuildCommand())
      ..addCommand(DevCommand())
      ..addCommand(TaskCommand())
      ..run(args);
  } on UsageException catch (error) {
    print(error);
    rethrow;
  }
}
