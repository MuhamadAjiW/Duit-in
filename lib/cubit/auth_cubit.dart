import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:liburan/services/auth_service.dart';
import 'package:liburan/services/user_service.dart';
import 'package:liburan/models/user_model.dart';

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

}