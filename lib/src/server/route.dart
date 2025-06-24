import 'dart:collection';

import 'package:file/file.dart';
import 'package:path/path.dart' as p;

typedef RouteParam = (String name, {Pattern? regex, bool? catchAll});

sealed class RouteBase {
  abstract final String path;
  abstract final List<RouteParam> params;
  abstract final String file;

  @override
  String toString() {
    return 'Route $path';
  }
}

class Route extends RouteBase {
  @override
  final String path;

  @override
  final List<RouteParam> params;

  @override
  final String file;

  final RequestMethod? method;

  Route(
      {required this.path,
      this.params = const [],
      this.method,
      required this.file});

  @override
  String toString() {
    return '${method?.name ?? 'ALL'} Route $path';
  }
}

enum RequestMethod {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
  HEAD,
  OPTIONS,
}

class RouteGroup extends RouteBase with ListMixin<RouteBase> {
  @override
  final String path;

  @override
  final List<RouteParam> params;

  @override
  final String file;

  final List<RouteBase> _routes;

  RouteGroup(this._routes,
      {required this.path, this.params = const [], required this.file});

  List<RouteBase> get rawRoutes => _routes;
  List<Route> get routes {
    return _routes.map((r) {
      return switch (r) {
        Route() => [r],
        // TODO: Handle this case.
        RouteGroup() => r.routes,
      };
    }).fold(
        <Route>[], (previous, current) => [...previous, ...current]).toList();
  }

  @override
  int get length => _routes.length;

  @override
  RouteBase operator [](int index) => _routes[index];

  @override
  void operator []=(int index, RouteBase value) => _routes[index] = value;

  @override
  set length(int newLength) => _routes.length = newLength;
}

RouteBase parseRoute(FileSystemEntity entity, [String? root]) {
  return switch (entity) {
    File f => _parseFileRoute(f, root),
    Directory d => _parseDirRoute(d, root),
    FileSystemEntity() =>
      throw UnsupportedError("Only files and directories are supported"),
  };
}

Route _parseFileRoute(File file, [String? root]) {
  root ??= p.current;

  final path = p.relative(file.path, from: root);
  final parts = p.split(p.setExtension(path, ''));

  final extension = p.extension(path);
  final method =
      switch (p.extension(path.replaceAll(extension, '')).toLowerCase()) {
    '.get' => RequestMethod.GET,
    '.post' => RequestMethod.POST,
    '.put' => RequestMethod.PUT,
    '.patch' => RequestMethod.PATCH,
    '.options' => RequestMethod.OPTIONS,
    '.head' => RequestMethod.HEAD,
    '.delete' => RequestMethod.DELETE,
    _ => null
  };

  final restParamItems = parts.where((p) => dotsRegex.hasMatch(p));
  RouteParam? catchAllParam;
  if (restParamItems.isNotEmpty) {
    final restParamItem = restParamItems.single;
    assert(
        parts.last == restParamItem, "Rest params can only be used at the end");
    final catchAllMatch = dotsRegex.firstMatch(restParamItem)!.group(1);
    final catchAllMatchSplit = catchAllMatch?.split('|') ?? [];

    catchAllParam = catchAllMatchSplit.length > 1
        ? (catchAllMatchSplit[0], regex: catchAllMatchSplit[1], catchAll: true)
        : (catchAllMatchSplit.first, regex: null, catchAll: true);
  }

  final List<RouteParam> params =
      parts.where((p) => regex.hasMatch(p)).map((p) {
    final match = regex.firstMatch(p)!.group(1);
    final routeMatchSplit = match?.split('|') ?? [];
    return routeMatchSplit.length > 1
        ? (routeMatchSplit[0], regex: routeMatchSplit[1], catchAll: false)
        : (routeMatchSplit.first, regex: null, catchAll: false);
  }).toList();

  if (catchAllParam != null) {
    if (params.any((p) => p.$1 == '...${catchAllParam?.$1}')) {
      params.removeWhere((p) => p.$1 == '...${catchAllParam?.$1}');
      params.add(catchAllParam);
    } else {
      params.add(catchAllParam);
    }
  }

  return Route(
      path: '/' +
          parts
              .map((part) {
                final path =
                    part.startsWith('[...') ? part : p.withoutExtension(part);
                if (dotsRegex.hasMatch(path)) {
                  final match = dotsRegex.firstMatch(path)!.group(1);
                  return '<$match|[^]*>';
                } else if (regex.hasMatch(path)) {
                  final match = regex.firstMatch(path)!.group(1);
                  return '<$match>';
                } else if (path.toLowerCase() == 'index') return null;
                return path;
              })
              .whereType<String>()
              .join('/'),
      params: params,
      method: method,
      file: file.path);
}

RouteGroup _parseDirRoute(Directory dir, [String? root]) {
  root ??= p.current;

  final path = p.relative(dir.path, from: root);
  final parts = p.split(p.setExtension(path, ''));

  final List<RouteParam> params =
      parts.where((p) => regex.hasMatch(p)).map((p) {
    final match = regex.firstMatch(p)!.group(1);
    final routeMatchSplit = match?.split('|') ?? [];
    return routeMatchSplit.length > 1
        ? (routeMatchSplit[0], regex: routeMatchSplit[1], catchAll: false)
        : (routeMatchSplit.first, regex: null, catchAll: false);
  }).toList();

  return RouteGroup(
      dir
          .listSync()
          .where((f) => f is Directory || f is File)
          .map((f) => parseRoute(f, root))
          .toList(),
      path: '/' +
          parts.map((p) {
            if (regex.hasMatch(p)) {
              final match = dotsRegex.firstMatch(p)!.group(1);
              return '<$match>';
            } else if (p.toLowerCase() == 'index') return null;
            return p;
          }).join('/'),
      params: params,
      file: dir.path);
}

final RegExp regex = RegExp(r'\[([^\]]+?)\]');
final RegExp dotsRegex = RegExp(r'\[\.{3}([^\]]+?)\]');
