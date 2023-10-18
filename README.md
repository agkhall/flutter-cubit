# Flutter Cubits

## Overview

This repository contains a minimal implementation of Cubits from `package:flutter_bloc` in Flutter.

Whilst I don't make use of the `Bloc` state management system, I am making use of its little brother: `Cubit`. In the rest of this README you'll find my notes synthesising what I was able to learn from the generous sources listed below.

## Notes

**Documentation and Tutorials:**
- [`package:flutter_bloc` - Dart Docs](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/Bloc-class.html)
- [Core concepts (package:flutter_bloc) - bloc](https://bloclibrary.dev/#/flutterbloccoreconcepts)
- [What is the BLoC Pattern? - flutterclutter.dev](https://www.flutterclutter.dev/flutter/basics/what-is-the-bloc-pattern/2021/2084/)
- [Cubits in Flutter: A Practical Guide - Amos Gross](https://www.amosgross.com/articles/flutter_cubits/)

**The difference:** BLoC $\supset$ Cubit

`Bloc`s and `Cubit`s are not widgets or data representation. Instead they stand between those two things, exposing functionality to the widgets so that actions can be invoked from the UI, and manipulating data in a controlled manner. They help prevent tight coupling between an application's data and presentation layers.

**Architectural overview:**
1. **State:** An object (encapsulated data model/representation) relevant to some aspect of an application. It is the thing actually being passed around--the state being managed.
2. **State Manager:** An object existing *between* UI and state which handles the manipulation of data based on user interaction with the UI layer, and the subsequent delivery of updated state back to the UI from the data layer.
3. **Provider:** A widget which should be inserted high up into the tree such that its subtree contains the widgets which uses the state(s) that it is providing and managing.
4. **Consumer:** A widget which should be inserted into a provider's subtree such that it can access it via `context`.

**State Manager:**
- `Bloc`: An object which exposes event triggers the UI layer and contains event-handling procedures to manipulate the data layer and output resulting `state`s accordingly.
- `Cubit`: An object passed down through the UI layer exposing methods which can directly manipulate `state` and subsequently return it to be provided again. It is essentially a `Bloc` which exposes methods which can be directly called, as opposed to a suite of events, thereby "removing a step".

**Provider Widgets:**
- [`BlocProvider`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocProvider-class.html): Initialises a `Bloc` or `Cubit` object and contains a subtree which has consumers.
- [`MultiBlocProvider`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/MultiBlocProvider-class.html): Contains a list `BlocProvider` to avoid nesting `BlocProviders` where multiple are necessary, thereby creating multiple instances of `Bloc`s or `Cubit`s for multifaceted state management.

**Consumer Widgets:**
- [`BlocBuilder`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocBuilder-class.html): Builds a new widget in response to a change in `state`.
- [`BlocListener`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocListener-class.html): Listens for a change in `state` and calls the `listener` callback function exactly once for each change in `state`.
- [`MultiBlocListener`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/MultiBlocListener-class.html): Contains a list of `BlocListener`s to avoid nesting `BlocListener`s where multiple are necessary, thereby containing multiple `listener`s to respond to changes in `state` in a multifaceted manner.
- [`BlocComsumer`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocConsumer-class.html): Literally combines the functionality of `BlocBuilder` and `BlocListener` together into a single widget to allow for both a `listener` and `builder` callback.
- [`BlocSelector`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocSelector-class.html): Calls its `selector` callback which returns a `state` to be used by the `builder` callback when building the widget, essentially allowing for preprocessing of a `state` prior to building.

**Utility Classes/Typedefs:**
- [`Change`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/Change-class.html): A class for representing a change in state comprised a `currentState` and `nextState` field holding `state`s of the same type but possibly having different values. They are created whenever a state change occurs, being accessible using a [BlocObserver](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocObserver-class.html) for monitoring purposes.
- [`Emitter`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/Emitter-class.html): A class used by an `EventHandler` with a `call()` method which emits a state.
- [`EventHandler`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/EventHandler.html): A typedef representing a function tying an event (which can be any type of data) to an `Emitter` which emits a state in response. They are responsible for reacting to incoming events and emitting zero or more states in response when using a `Bloc`.
- [`Transition`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/Transition-class.html): A class for representing a change from one state to another along with the event which incited that change. They are created whenever a state change occurs as a result of an event, being accessible using a [`BlocObserver`](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocObserver-class.html) for monitoring purposes.