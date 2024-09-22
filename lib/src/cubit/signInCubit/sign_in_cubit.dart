import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/sgin_in_model.dart';
import '../../data/repository/sign_in_repo.dart';
import '../../pages/home_page.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.signInRepo) : super(SignInInitial());

  SignInRepo signInRepo;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Add context as a parameter to handle navigation
  signIn(BuildContext context) async {
    emit(SignInLoading());

    final data = SignInModel(
        userName: userNameController.text, password: passwordController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );

    final response = await signInRepo.postData(data.toJson());
  }
}
