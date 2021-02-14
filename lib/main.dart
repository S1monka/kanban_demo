import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/cubit/auth_cubit.dart';
import 'auth/view/auth_screen.dart';
import 'utility/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(color: Colors.indigo),
          buttonColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated)
              return Container(
                child: Text("Login successful"),
              );

            return AuthScreen();
          },
        ),
      ),
    );
  }
}
