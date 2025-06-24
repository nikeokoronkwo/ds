import 'package:ds/src/config.dart';
import 'package:ds/src/server/route.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as p;
import 'package:toml/toml.dart';

typedef RouteMap = List<RouteBase>;

class DSApplication {
  final RouteMap routes;
  final DSConfig? config;

  DSApplication({required this.routes, this.config});

  // TODO: Return type
  // 1. entrypoint (maybe)
  // 2. output directory (if none just gen)
  Future<void> build(String outputDir, {FileSystem? fileSystem}) async {
    fileSystem ??= LocalFileSystem();

    // 1. build route map

    // 2. for each route

    // 3. MAIN
    // 3a. Create DS App
    // 3b. Plug in DS plugins, if any
    // 3c. Create composed handler 
    // 3d. Add default middleware
    // 3e. Add router
    // 3f. Add tasks
    // 3g. implement server if any
  }

  Future copyPublicAssets(String outputDir, {FileSystem? fileSystem}) async {

  }

  Future prerender(String outputDir, {FileSystem? fileSystem}) async {}
}

Future<DSApplication> createDsApplication(
    {required String directory,
    bool dev = false,
    String? config,
    String preset = 'vm'}) async {
  final fileSystem = LocalFileSystem();
  final dir = fileSystem.directory(directory);
  if (!dir.existsSync()) {
    throw Exception('Directory does not exist: $dir');
  }

  final tomlFileExists =
      fileSystem.file(config ?? p.join(p.current, 'ds.toml')).existsSync();
  DSConfig? dsConfig;
  if (tomlFileExists) {
    final tomlConfig =
        await TomlDocument.load(config ?? p.join(p.current, 'ds.toml'));
    final configMap = tomlConfig.toMap();
    dsConfig = DSConfig.fromJson(configMap);
  }

  // find routes directory
  final routesDir = dir.childDirectory('routes');
  final middlewareDir = dir.childDirectory('middleware');
  final tasksDir = dir.childDirectory('tasks');
  final publicDir = dir.childDirectory('public');
  final pluginsDir = dir.childDirectory('plugins');

  // get routes in route directory
  final routes = routesDir
      .listSync(recursive: true)
      .whereType<File>()
      .map((f) => parseRoute(f, routesDir.path));

  print(routes);

  // form route map using routes in dir
  // TODO: In future route maps should contain info of what is in each route, using analyzer

  // use route map to generate router

  // generate DS app

  // build code for app

  // write files to .ds
  throw UnimplementedError("TODO: Implement createDsApplication");
}

abstract interface class DSPresetTypeBase {}

enum DSPresetType implements DSPresetTypeBase {
  vm, vm_workers,
  dev, node, deno,
  other;
}
