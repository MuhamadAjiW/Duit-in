import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:liburan/models/log_model.dart';
import 'package:liburan/services/logs_service.dart';

part 'log_state.dart';

class LogCubit extends Cubit<LogState> {
  LogCubit() : super(LogInitial());

  void addLog({
    required String keterangan,
    required int nilai,
    required String uid,
    required DateTime waktu
  }) async {
    try{
      emit(LogLoading());
      LogModel log =
        await LogService().addLog(keterangan: keterangan, nilai: nilai, uid: uid, waktu: waktu);
      emit(LogSuccess(log));
    } catch(e){
      emit(LogFailed(e.toString()));
    }
  }
}