part of 'log_cubit.dart';

abstract class LogState extends Equatable{
  const LogState();

  @override
  List<Object> get props {
    return [];
  }
}

class LogInitial extends LogState {}

class LogLoading extends LogState {}

class LogSuccess extends LogState {
  final LogModel log;
  LogSuccess(this.log);
  @override
  List<Object> get props{
    return [log];
  }
}

class LogFailed extends LogState {
  final String error;
  LogFailed(this.error);
  @override
  List<Object> get props {
    return [error];
  }
}