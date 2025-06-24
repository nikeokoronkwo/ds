// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DSConfig _$DSConfigFromJson(Map<String, dynamic> json) => DSConfig(
      port: (json['port'] as num?)?.toInt(),
      host: json['host'] as String?,
      routes: json['routes'] == null
          ? null
          : DSRouteConfig.fromJson(json['routes'] as Map<String, dynamic>),
      plugins:
          (json['plugins'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DSConfigToJson(DSConfig instance) => <String, dynamic>{
      'port': instance.port,
      'host': instance.host,
      'routes': instance.routes,
      'plugins': instance.plugins,
    };

DSRouteConfig _$DSRouteConfigFromJson(Map<String, dynamic> json) =>
    DSRouteConfig(
      extend: (json['extend'] as List<dynamic>?)
              ?.map((e) => DSRoute.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DSRouteConfigToJson(DSRouteConfig instance) =>
    <String, dynamic>{
      'extend': instance.extend,
    };

DSRoute _$DSRouteFromJson(Map<String, dynamic> json) => DSRoute(
      path: json['path'] as String,
      file: json['file'] as String,
    );

Map<String, dynamic> _$DSRouteToJson(DSRoute instance) => <String, dynamic>{
      'path': instance.path,
      'file': instance.file,
    };
