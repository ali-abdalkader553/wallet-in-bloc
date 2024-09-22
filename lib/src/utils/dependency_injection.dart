import '../cubit/signInCubit/sign_in_cubit.dart';
import '../data/datasource/remote/api_server.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/sign_in_repo.dart';

final getIt=GetIt.instance;
Future<void> setUpGetIt()async{
  ApiService apiServices = ApiService();
  getIt.registerLazySingleton<SignInRepo>(() => SignInRepo(apiServices));
  getIt.registerLazySingleton<SignInCubit>(() => SignInCubit( getIt()));
}