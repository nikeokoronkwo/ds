import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class DSConfig {
  final int? port;
  final String? host;
  final DSRouteConfig? routes;
  final List<String>? plugins;

  DSConfig({this.port, this.host, this.routes, this.plugins});

  factory DSConfig.fromJson(Map<String, dynamic> json) =>
      _$DSConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DSConfigToJson(this);
}

@JsonSerializable()
class DSRouteConfig {
  final List<DSRoute>? extend;

  DSRouteConfig({this.extend = const []});

  factory DSRouteConfig.fromJson(Map<String, dynamic> json) =>
      _$DSRouteConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DSRouteConfigToJson(this);
}

@JsonSerializable()
class DSRoute {
  final String path;
  final String file;

  DSRoute({required this.path, required this.file});

  factory DSRoute.fromJson(Map<String, dynamic> json) =>
      _$DSRouteFromJson(json);

  Map<String, dynamic> toJson() => _$DSRouteToJson(this);
}
