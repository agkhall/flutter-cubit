import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'example_state.dart';

class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit() : super(const ExampleState());

  void updateFoo(String value) {
    emit(ExampleState(foo: value, bar: state.bar));
  }
}
