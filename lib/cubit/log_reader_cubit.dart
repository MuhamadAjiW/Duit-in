import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:duit.in/models/log_model.dart';
import 'package:duit.in/services/logs_service.dart';

part 'log_reader_state.dart';


class LogReaderCubit extends Cubit<LogReaderState> {
  LogReaderCubit() : super(LogReaderInitial());

  void readLogs(uid) async{
    try{
      emit(LogReaderLoading());
      List<LogModel> logs = await LogService().readLogs(uid: uid);
      emit(LogReaderSuccess(logs));
    } catch(e){
      emit(LogReaderFailed(e.toString()));
    }
  }
}