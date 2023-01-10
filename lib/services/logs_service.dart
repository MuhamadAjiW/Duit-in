
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duit.in/models/log_model.dart';

class LogService {
  CollectionReference _logsReference =
    FirebaseFirestore.instance.collection('logs');

  Future<LogModel> addLog({
    required String uid,
    required String nilaiRaw,
    required String keterangan,
    required DateTime waktu,
    String notes = '-',
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
      String stamp = waktu.toString().substring(0,23);
      await _logsReference.doc(stamp).set({
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

  Future<LogModel> editLog({
    required String oldUid,
    required String nilaiRaw,
    required String keterangan,
    required DateTime oldWaktu,
    String notes = '-',
  }) async {
    print(oldWaktu.toString());
    try{
      final nilai = int.parse(nilaiRaw);
      LogModel log = LogModel(
        uid: oldUid,
        nilai: nilai,
        keterangan: keterangan,
        waktu: oldWaktu,
        notes: notes,
      );
      await _logsReference.doc(oldWaktu.toString()).update({
        'nilai': nilai,
        'keterangan' : keterangan,
        'notes' : notes,
      });
      return log;
    } catch (e){
      throw e;
    }
  }

  Future<void> deleteLog({
    required DateTime oldWaktu,
  }) async {
    try{
      await _logsReference.doc(oldWaktu.toString()).delete();
    } catch(e){
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