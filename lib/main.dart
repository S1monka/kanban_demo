import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/cubit/auth_cubit.dart';
import 'auth/view/auth_screen.dart';
import 'board/cubit/board_cubit.dart';
import 'board/view/board_screen.dart';
import 'utility/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp(App());
}

class App extends StatelessWidget {
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
              return BlocProvider<BoardCubit>(
                create: (context) => BoardCubit(
                  authToken: context.read<AuthCubit>().state.token,
                ),
                child: BoardScreen(),
              );

            return AuthScreen();
          },
        ),
      ),
    );
  }
}
