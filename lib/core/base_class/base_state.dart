import 'failure_response.dart';

abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class SuccessState<T> extends BaseState {
  final T data;

  SuccessState({required this.data});
}

class FailureState extends BaseState {
  final FailureResponse failureResponse;

  FailureState({required this.failureResponse});
}
