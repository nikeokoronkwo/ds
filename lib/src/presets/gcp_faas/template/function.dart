// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:functions_framework/functions_framework.dart';
import 'package:json_annotation/json_annotation.dart';

part 'functions.g.dart';

@JsonSerializable()
class GreetingRequest {
  final String? name;

  GreetingRequest({this.name});

  factory GreetingRequest.fromJson(Map<String, dynamic> json) =>
      _$GreetingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GreetingRequestToJson(this);

  @override
  bool operator ==(Object other) =>
      other is GreetingRequest && other.name == name;

  @override
  int get hashCode => name.hashCode;
}

@JsonSerializable()
class GreetingResponse {
  final String salutation;
  final String name;

  GreetingResponse({required this.salutation, required this.name});

  factory GreetingResponse.fromJson(Map<String, dynamic> json) =>
      _$GreetingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GreetingResponseToJson(this);

  @override
  bool operator ==(Object other) =>
      other is GreetingResponse &&
      other.salutation == salutation &&
      other.name == name;

  @override
  int get hashCode => salutation.hashCode ^ name.hashCode;
}

@CloudFunction()
GreetingResponse function(GreetingRequest request) {
  final name = request.name ?? 'World';
  final json = GreetingResponse(salutation: 'Hello', name: name);
  return json;
}