import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:liburan/models/user_model.dart';


class UserService{
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async{
    try{
      _userReference.doc(user.uid).set({
        'name': user.name,
        'email': user.email,
      });
    } catch(e){
      throw e;
    }
  }

  Future<UserModel> getUserByUid(String uid) async{
    try{
      DocumentSnapshot snapshot = await _userReference.doc(uid).get();
      return UserModel(
          uid: uid,
          email: snapshot['email'],
          name: snapshot['name']
      );
    } catch(e){
      throw e;
    }
  }


  Future<UserModel> updateName(UserModel oldUser, String newName) async{
    try{
      _userReference.doc(oldUser.uid).update({
        'name': newName,
      });
      DocumentSnapshot snapshot = await _userReference.doc(oldUser.uid).get();
      return UserModel(
          uid: oldUser.uid,
          email: snapshot['email'],
          name: snapshot['name']);
    } catch (e){
      throw e;
    }
  }

}