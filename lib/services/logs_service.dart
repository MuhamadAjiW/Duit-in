
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
    String notes = '',
  }) async {
    try{
      final nilai = int.parse(nilaiRaw);
      LogModel log = LogModel(
          uid: uid,
          nilai: nilai,
          keterangan: keterangan,
          waktu: DateTime.now(),
          notes: notes,
      );
      await _logsReference.doc(waktu.toString()).set({
        'uid': uid,
        'nilai': nilai,
        'keterangan' : keterangan,
        'waktu' : waktu,
        'notes' : notes,
      });
      return log;
    } catch (e){
      throw e;
    }
  }

  Future<List<LogModel>> readLogs({
    required String uid,
  }) async {
    try {
      QuerySnapshot result = await _logsReference.where("uid", isEqualTo: uid).get();
      List<LogModel> logs = result.docs.map((e) {
        return LogModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return logs;
    } catch(e){
      throw e;
    }
  }
}