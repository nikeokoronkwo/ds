/// Defines a new preset
class DSPreset {
  String name;
  List<String> dependencies;
  DSEntrypointHandler? createEntrypoint;
  DSFunctionHandler? createFunction;
  Map<String, String> commands;
  DSOutputHandler? output;

  // TODO: Handler plugin

  DSPreset({
    required this.name,
    this.dependencies = const [],
    this.createEntrypoint,
    this.createFunction,
    this.commands = const {}
  });
}

typedef DSEntrypointHandler = Function;
typedef DSFunctionHandler = Function;
typedef DSOutputHandler = ({String dir, String serverDir, String publicDir}) Function(String root);