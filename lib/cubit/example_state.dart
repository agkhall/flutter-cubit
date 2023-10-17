part of 'example_cubit.dart';

@immutable
class ExampleState {
  const ExampleState({
    this.foo = "Test",
    this.bar = 42,
  });

  final String foo;
  final int bar;

  @override
  bool operator ==(Object other) {
    return other is ExampleState && other.foo == foo && other.bar == bar;
  }

  @override
  int get hashCode => Object.hash(foo, bar);
}
