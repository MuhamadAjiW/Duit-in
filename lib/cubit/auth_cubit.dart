import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:duit.in/services/auth_service.dart';
import 'package:duit.in/services/user_service.dart';
import 'package:duit.in/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user =
        await AuthService().signIn(email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user =
      await AuthService().signUp(name: name, email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try{
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e){
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String uid) async{
    try {
      UserModel user = await UserService().getUserByUid(uid);
      emit(AuthSuccess(user));
    } catch(e){
      emit(AuthFailed(e.toString()));
    }
  }

  void updateName({
    required UserModel oldUser,
    required String newName}) async{
    try{
      emit(AuthLoading());
      UserModel user = await UserService().updateName(oldUser, newName);
      emit(AuthSuccess(user));
    } catch(e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updatePass({
    required UserModel oldUser,
    required String oldPass,
    required String newPass,
    required String confPass,
  }) async{
    try{
      final user = await FirebaseAuth.instance.currentUser;
      if (newPass.length < 8){


        emit(AuthFailed("Password must be longer than 8 characters"));
        emit(AuthSuccess(oldUser));
      }
      else if(newPass != confPass){
        emit(AuthFailed("Password confirmation failed"));
        emit(AuthSuccess(oldUser));
      }
      else{
        if (user != null){
          user.reauthenticateWithCredential(
              EmailAuthProvider.credential(
                  email: user.email.toString(),
                  password: oldPass)
          ).then((value) async => {
            emit(AuthLoading()),
            await AuthService().updatePass(newPass),
            signOut()}
          ).onError((error, stackTrace) => {
            emit(AuthFailed("Old Password invalid")),
            emit(AuthSuccess(oldUser))
          });
        }
      }
    } catch(e) {
      emit(AuthFailed(e.toString()));
    }
  }
}