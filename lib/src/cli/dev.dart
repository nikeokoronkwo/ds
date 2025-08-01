import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ds/src/app.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

/// The run command

class DevCommand extends Command {
  final name = 'dev';
  final description = 'Start the development version of the server';

  Future<void> run() async {
    // find user directory for server
    final currentDirPath = (argResults?.rest ?? []).isEmpty
        ? p.current
        : p.isAbsolute(argResults!.rest.first)
            ? argResults!.rest.first
            : p.join(p.current, argResults?.rest.first);

    // create ds application
    var dsApp =
        await createDsApplication(directory: currentDirPath, dev: true);

    // run .ds

    // watch file system
    final watcher = DirectoryWatcher(currentDirPath);
    watcher.events.listen((event) async {
      // TODO: Log
      dsApp = await createDsApplication(directory: currentDirPath, dev: true);

      
    });
  }
}
