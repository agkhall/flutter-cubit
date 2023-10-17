import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/example_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ExampleCubit(),
        child: const Page(),
      ),
    );
  }
}

/// I don't know if there's a cleaner way to do this, but you need to create a
/// separate widget so that a new [BuildContext] is available further down the
/// tree. If you didn't do this (which I tried and banged my head against a wall
/// over for a good quarter of an hour), then you end up trying to use the
/// [BuildContext] from the [MainApp], which is above the [BlocProvider].
class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ExampleCubit, ExampleState>(
            builder: (context, state) {
              return Text(state.foo);
            },
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<ExampleCubit>(context).updateFoo('Hi');
            },
            child: const Text('Press me!'),
          ),
        ],
      ),
    );
  }
}
