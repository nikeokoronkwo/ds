# Routing
DS uses file-based routing to serve routes on the server.

## Basic Routing
Routes are gotten based on the file

`routes/hello.dart` --> `/hello`
`routes/goodbye/index.dart` --> `/goodbye`
`routes/visit/place.dart` --> `/visit/place`

## Pattern Matching Routing
DS also supports specifying parameters in routes using pattern matching. 
These parameters can be accessed through the event object or by using `getParams`

### Basic
Basic pattern matching can be done using square brackets on the variable to match for:
`routes/hello/[id].dart` ---> `/hello/<id>`

The variable `id` can then be gotten via `getParams`
```dart
final id = getParams(event, 'id');
```

The following routes are matched: `/hello/123`, `/hello/world`, `/hello/2mfocj35mgjg`.

Multiple variables can be matched in a route
`routes/hello/[id]/versions/[version].dart` ---> `/hello/<id>/versions/<version>.dart`

### Catch All
A catch-all route can be used for 
They are defined using triple dots at the end:


## Method Routing
DS supports routing for specific method by specifying the method in the file name. `hello.get.dart` defines the `/hello` route for GET methods only

`routes/goodbye/index.get.dart` --> GET `/goodbye`
`routes/goodbye/index.delete.dart` --> DELETE `/goodbye`

## WebSockets
A websocket route can be made by specifying `ws` in the file name e.g `repl.ws.dart` defines a `/repl` websocket route

