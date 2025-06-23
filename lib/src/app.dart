import 'dart:io';

import 'package:path/path.dart' as p;

class DSApplication {

}

Future<DSApplication> createDsApplication({
  required String directory,
  bool dev = false,
  String? config,
  String preset = 'vm'
}) async {
  final dir = Directory(directory);
  if (!dir.existsSync()) {
    throw Exception('Directory does not exist: $dir');
  }
  
  // find routes directory
  final routesDir = Directory(p.join(dir.path, 'routes'));
  final middlewareDir = Directory(p.join(dir.path, 'middleware'));
  final tasksDir = Directory(p.join(dir.path, 'tasks')); 
  final publicDir = Directory(p.join(dir.path, 'public'));
  final pluginsDir = Directory(p.join(dir.path, 'plugins'));

  // get routes in route directory
  print(routesDir.listSync(recursive: true));

  // form route map using routes in dir
  // TODO: In future route maps should contain info of what is in each route, using analyzer

  // use route map to generate router

  // generate DS app

  // build code for app

  // write files to .ds
  throw UnimplementedError("TODO: Implement createDsApplication");
}

abstract interface class DSPresetBase {}

enum DSPreset implements DSPresetBase {
  vm, vm_workers, dev, other;
}