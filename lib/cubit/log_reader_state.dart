part of 'log_reader_cubit.dart';

abstract class LogReaderState extends Equatable{
  const LogReaderState();

  @override
  List<Object> get props {
    return [];
  }
}

class LogReaderInitial extends LogReaderState {}

class LogReaderLoading extends LogReaderState {}

class LogReaderSuccess extends LogReaderState {
  final List<LogModel> logs;
  LogReaderSuccess(this.logs);
  @override
  List<Object> get props{
    return [logs];
  }
}

class LogReaderFailed extends LogReaderState {
  final String error;
  LogReaderFailed(this.error);
  @override
  List<Object> get props {
    return [error];
  }
}