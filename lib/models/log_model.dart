import 'package:equatable/equatable.dart';

class LogModel extends Equatable{
  final String keterangan;
  final int nilai;
  final String uid;
  final DateTime waktu;

  LogModel({
    required this.keterangan,
    required this.nilai,
    required this.uid,
    required this.waktu
  });

  @override
  List<Object?> get props {
    return [keterangan, nilai, uid, waktu];
  }
}