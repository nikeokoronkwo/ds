# Routing
DS uses file-based routing to serve routes on the server.

## Basic Routing
Routes are gotten based on the file

`routes/hello.dart` --> `/hello`
`routes/goodbye/index.dart` --> `/goodbye`
`routes/visit/place.dart` --> `/visit/place`

## Pattern Matching Routing
DS also supports specifying parameters in routes using pattern matching. These parameters can be accessed through the event object

### Basic

### Catch All


## Method Routing
DS supports routing for specific method by specifying the method in the file name. `hello.get.dart` defines the `/hello` route for GET methods only

`routes/goodbye/index.get.dart` --> GET `/goodbye`
`routes/goodbye/index.delete.dart` --> DELETE `/goodbye`

## WebSockets
A websocket route can be made by specifying `ws` in the file name e.g `repl.ws.dart` defines a `/repl` websocket route

