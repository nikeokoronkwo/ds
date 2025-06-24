import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ds/src/app.dart';
import 'package:path/path.dart' as p;

class BuildCommand extends Command {
  String name = 'build';
  String description = 'Build your server for deployment';

  @override
  Future<void> run() async {
    // find user directory for server
    final currentDirPath = (argResults?.rest ?? []).isEmpty
        ? p.current
        : p.isAbsolute(argResults!.rest.first)
            ? argResults!.rest.first
            : p.join(p.current, argResults?.rest.first);

    // create ds application
    final dsApp =
        await createDsApplication(directory: currentDirPath, dev: false);
  }
}
