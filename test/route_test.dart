import 'dart:math';

import 'package:ds/src/server/route.dart';
import 'package:file/memory.dart';
import 'package:test/test.dart';

final testMap = {
  '/index.dart': {
    'path': '/',
    'params': [],
  },
  '/foo.dart': {
    'path': '/foo',
    'params': [],
  },
  '/bar.get.dart': {'path': '/bar', 'params': [], 'method': 'GET'},
  '/bean.options.dart': {'path': '/bean', 'params': [], 'method': 'OPTIONS'},
  '/foo/bar.dart': {'path': '/foo/bar', 'params': []},
  '/foo/bar/index.dart': {
    'path': '/foo/bar',
    'params': [],
  },
  '/foo/[id].dart': {
    'path': '/foo/<id>',
    'params': [
      {'name': 'id'}
    ]
  },
  '/bar/qux/[...quz].dart': {
    'path': '/bar/qux/<quz|[^]*>',
    'params': [
      {'name': 'quz', 'all': true}
    ]
  },
  '/bar/qux/[...quz].get.dart': {
    'path': '/bar/qux/<quz|[^]*>',
    'method': 'GET',
    'params': [
      {'name': 'quz', 'all': true}
    ]
  }
};

void main() {
  group('Route Matching', () {
    final fs = MemoryFileSystem.test();
    for (var entry in testMap.entries) {
      setUp(() {
        fs.file(entry.key).createSync(recursive: true);
      });

      test(entry.key, () {
        final route = parseRoute(fs.file(entry.key), '/');
        expect(route.path, equals(entry.value['path']));
        expect(route.params,
            hasLength(equals((entry.value['params'] as List?)?.length ?? 0)));
        expect((route as Route).method?.name, equals(entry.value['method']));
        route.params.forEach((p) {
          assert((entry.value['params'] as List).any((i) => i['name'] == p.$1));

          final item = (entry.value['params'] as List)
              .firstWhere((i) => i['name'] == p.$1);
          expect(item['all'] ?? false, equals(p.catchAll));
        });
      });
    }
  });
}
