
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
      String idval = '';

      await _logsReference.add({
        'uid': uid,
        'nilai': nilai,
        'keterangan' : keterangan,
        'waktu' : waktu,
        'notes' : notes,
      }).then((value){
        idval = value.id;
      });
      print(idval);
      LogModel log = LogModel(
        logId: idval,
        uid: uid,
        nilai: nilai,
        keterangan: keterangan,
        waktu: DateTime.now(),
        notes: notes,
      );
      return log;
    } catch (e){
      throw e;
    }
  }

  Future<LogModel> editLog({
    required String id,
    required String oldUid,
    required String nilaiRaw,
    required String keterangan,
    required DateTime oldWaktu,
    String notes = '-',
  }) async {
    try{
      final nilai = int.parse(nilaiRaw);
      await _logsReference.doc(id).update({
        'nilai': nilai,
        'keterangan' : keterangan,
        'notes' : notes,
      });

      LogModel log = LogModel(
        logId: id,
        uid: oldUid,
        nilai: nilai,
        keterangan: keterangan,
        waktu: oldWaktu,
        notes: notes,
      );

      return log;
    } catch (e){
      throw e;
    }
  }

  Future<void> deleteLog({
    required String logId,
  }) async {
    try{
      await _logsReference.doc(logId).delete();
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
        return LogModel.fromJson(e.data() as Map<String, dynamic>, e.id);
      }).toList();
      return logs;
    } catch(e){
      throw e;
    }
  }
}