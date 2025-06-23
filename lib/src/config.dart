

import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class DSConfig {
  final int? port; 
  final String? host;

  DSConfig({
    this.port,
    this.host
  });

  factory DSConfig.fromJson(Map<String, dynamic> json) => _$DSConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DSConfigToJson(this);
}