# DS
DS (short for "Dart Server") is a Dart server-side framework designed to be platform-agnostic, powerful, scalable, fast and minimal. It takes a different approach on servers than most Dart frameworks.
DS can be used for fully built servers, serverless functions, and more!

> NOTE: DS is experimental: I have not started much work on it. If you like the idea, feel free to message me and we can chat about it.

## Why?
DS was designed to suit my needs for a robust server-side framework. 
<!--- I liked Dart as a language, but wanted to use it more in the stuff I was doing. While [making websites]() is still a great possibility for Dart,  -->

## Goals
- Deployment-agnostic: DS is designed to work on every platform Dart can support, which includes JavaScript platforms. This makes it possible to use the expressiveness

Although DS is minimal, you might find current solutions much better for making small/tiny servers. 

> NOTE: While it is possible to deploy a DS server on JavaScript runtimes, it is recommended that you do not use JavaScript runtimes unless you really have to. 

## Comparison
DS takes an approach different from most Dart server-side frameworks like Pharoah, Angel, etc.
- Platform-agnostic: DS is the first
- DS is designed to take care of the annoying parts, so you can focus more on 
- Built ontop of Shelf: DS is built ontop of well supported tools, including [Dart's Shelf](https://pub.dev/packages/shelf).
- Web Standards: DS is designed to support and respect Web Standards by default
- Fast: DS is designed to be as fast as Dart can be, and can even [be faster](#performance)
- Pick the tools you need: Only core tools are supported by default. You can add other packages as needed. Most packages are designed to be usable even outside of DS and do not force you to use them in DS.

## Performance
DS is designed to be as fast as the deployment platform can be

<!--- DS will, later on, come with an even faster and more performant implementation of shelf_io, as well as its own concurrency system for working with requests easily. -->


## Flutter
I have plans of basic, server side support for Flutter, including support for 
- Server-driven UI


## Inspirations
- [`nitro`](https://nitro.build)
