import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:liburan/models/log_model.dart';
import 'package:liburan/services/logs_service.dart';

part 'log_state.dart';

class LogCubit extends Cubit<LogState> {
  LogCubit() : super(LogInitial());

  void addLog({
    required String uid,
    required String nilaiRaw,
    required String keterangan,
    required DateTime waktu,
    String notes = '-',
  }) async {
    try{
      emit(LogLoading());
      LogModel log =
        await LogService().addLog(uid: uid, nilaiRaw: nilaiRaw, keterangan: keterangan, waktu: waktu, notes: notes);
      emit(LogSuccess(log));
      emit(LogInitial());
    } catch(e){
      emit(LogFailed(e.toString()));
      emit(LogInitial());
    }
  }
}