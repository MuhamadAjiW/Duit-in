
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liburan/models/log_model.dart';

class LogService {
  CollectionReference _logsReference =
    FirebaseFirestore.instance.collection('logs');

  Future<LogModel> addLog({
    required String keterangan,
    required int nilai,
    required String uid,
    required DateTime waktu,
  }) async {
    try{
      LogModel log = LogModel(
          keterangan: keterangan,
          nilai: nilai,
          uid: uid,
          waktu: DateTime.now());
      await _logsReference.doc(waktu.toString()).set(log);
      return log;
    } catch (e){
      throw e;
    }
  }
}