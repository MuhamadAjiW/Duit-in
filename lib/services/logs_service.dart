
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liburan/models/log_model.dart';

class LogService {
  CollectionReference _logsReference =
    FirebaseFirestore.instance.collection('logs');

  Future<LogModel> addLog({
    required String uid,
    required String nilaiRaw,
    required String keterangan,
    required DateTime waktu,
  }) async {
    try{
      final nilai = int.parse(nilaiRaw);
      LogModel log = LogModel(
          uid: uid,
          nilai: nilai,
          keterangan: keterangan,
          waktu: DateTime.now());
      await _logsReference.doc(waktu.toString()).set({
        'uid': uid,
        'nilai': nilai,
        'keterangan' : keterangan,
        'waktu' : waktu,
      });
      return log;
    } catch (e){
      throw e;
    }
  }
}