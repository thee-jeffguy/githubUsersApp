import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  runApp(const MyApp());
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
            SearchUsersByUsernameUsecase(repository), // Pass the repository as a positional argument
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserDetailsProvider(
            GetUserDetailsUsecase(repository),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GITHUB USERS APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
