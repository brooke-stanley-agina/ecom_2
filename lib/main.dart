import 'package:ecom_2/blocs/auth_bloc.dart';
import 'package:ecom_2/config/app_router.dart';
import 'package:ecom_2/repositories/auth/auth_repository.dart';
import 'package:ecom_2/repositories/user/user_repository.dart';
import 'package:ecom_2/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_block_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => AuthRepository(),
            ),
            RepositoryProvider(create: (context) => UserRepository())
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: ((context) => AuthBloc(
                      authRepository: context.read<AuthRepository>(),
                      userRepository: context.read<UserRepository>())))
            ],
            child: const MaterialApp(
              title: 'Ecommerce App',
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute: SplashScreen.routeName,
            ),
          ),
        ));
  }
}
