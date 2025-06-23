// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DSConfig _$DSConfigFromJson(Map<String, dynamic> json) => DSConfig(
      port: (json['port'] as num?)?.toInt(),
      host: json['host'] as String?,
    );

Map<String, dynamic> _$DSConfigToJson(DSConfig instance) => <String, dynamic>{
      'port': instance.port,
      'host': instance.host,
    };
