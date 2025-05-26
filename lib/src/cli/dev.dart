import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;

/// The run command

class DevCommand extends Command {
  final name = 'dev';
  final description = 'Start the development version of the server';

  void run() {
    // find user directory for server
    final currentDirPath = (argResults?.rest ?? []).isEmpty
        ? p.current
        : p.isAbsolute(argResults!.rest.first)
            ? argResults!.rest.first
            : p.join(p.current, argResults?.rest.first);
    
    final currentDir = Directory(currentDirPath);
    if (!currentDir.existsSync()) {
      print('Directory does not exist: $currentDirPath');
      return;
    }

    

    // create ds application


    // find routes directory

    // get routes in route directory

    // form route map using routes in dir

    // use route map to generate router

    // write files to .ds

    // run .ds
  }
}

class DSApplication {
  // This class would represent the DS application
  // It would contain methods to handle routes, middleware, etc.
}

class DSBuiltApplication extends DSApplication {
  // This class would represent the built DS application
  // It would contain methods to handle the built application
}

// It would initialize the application with the necessary configurations
DSApplication createDsApplication(String root) {
  // This function would create a DS application instance
  
  // find .ds directory
  final dsDirPath = initialiseDsDirectory(root);
  return DSApplication();
}

String initialiseDsDirectory(String root) {
  final dsDirPath = p.join(root, '.ds');
  final dsDir = Directory(dsDirPath);

  // check if .ds directory exists, if not create it
    // else overwrite it (eventually)
  if (!dsDir.existsSync()) {
    dsDir.createSync(recursive: true);
    // print('Created .ds directory at $dsDirPath');
  } else {
    // print('.ds directory already exists at $dsDirPath');
  }

  // Additional setup can be done here, like creating default files

  return dsDirPath;
}