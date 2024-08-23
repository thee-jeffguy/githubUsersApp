import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/Presentation/providers/connectivity_provider.dart';
import 'package:test_drive/domain/repositories/user_repository.dart';
import 'package:test_drive/domain/usecases/search_by_username_usecase.dart';
import 'package:test_drive/presentation/providers/user_provider.dart';
import 'package:test_drive/presentation/providers/user_details_provider.dart';
import '../Presentation/Screens/splash_screen.dart';
import 'data/data_source/data_source.dart';
import 'data/repository/repository_impl.dart';
import 'package:http/http.dart' as http;
import 'domain/usecases/get_user_details_usecase.dart';
import 'domain/usecases/get_users_usecase.dart';


void main() {
  setupDependencies();
  runApp(const MyApp());
}

void setupDependencies(){
  final getIt = GetIt.instance;
  
  getIt.registerLazySingleton<GithubDataSource>(() => GithubDataSource(http.Client as http.Client));
  getIt.registerLazySingleton<UserRepository>(() => GitHubRepositoryImpl(getIt<GithubDataSource>()));
  getIt.registerLazySingleton<GetUsersUsecase>(() => GetUsersUsecase(repository: getIt<UserRepository>()));
  getIt.registerLazySingleton<GetUserDetailsUsecase>(() => GetUserDetailsUsecase(getIt<UserRepository>()));
  getIt.registerLazySingleton<SearchUsersByUsernameUsecase>(() => SearchUsersByUsernameUsecase(getIt<UserRepository>()));
  getIt.registerFactory<UserProvider>(() => UserProvider(getIt<GetUsersUsecase>(), getIt<SearchUsersByUsernameUsecase>()));
  getIt.registerFactory<UserDetailsProvider>(() => UserDetailsProvider(getIt<GetUserDetailsUsecase>()));
  getIt.registerFactory<InternetConnectionProvider>(() => InternetConnectionProvider());

  
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final dataSource = GithubDataSource(httpClient);
    final repository = GitHubRepositoryImpl(dataSource);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            GetUsersUsecase(repository: repository),
            SearchUsersByUsernameUsecase(repository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserDetailsProvider(
            GetUserDetailsUsecase(repository),
          ),
        ),
        ChangeNotifierProvider(create: (_) => InternetConnectionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GITHUB USERS APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade200),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
