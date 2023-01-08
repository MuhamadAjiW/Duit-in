import 'package:equatable/equatable.dart';

class LogModel extends Equatable{
  final String keterangan;
  final int nilai;
  final String uid;
  final DateTime waktu;

  LogModel({
    required this.uid,
    required this.nilai,
    required this.keterangan,
    required this.waktu,
  });

  @override
  List<Object?> get props {
    return [uid, nilai, keterangan, waktu];
  }
}