import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  TextFormField _buildLoginField() {
    return TextFormField(
      obscureText: false,
      controller: _loginController,
      validator: (value) => value.length < 4 ? "Minimum is 4 characters" : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        hintText: "Login",
        labelStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: _obscurePassword,
      controller: _passwordController,
      validator: (value) => value.length < 8 ? "Minimum is 8 characters" : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        hintText: "Password",
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.lock : Icons.lock_open),
          onPressed: () => setState(
            () {
              _obscurePassword = !_obscurePassword;
            },
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  MaterialButton _buildSubmitButton(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      padding: EdgeInsets.symmetric(vertical: 8),
      minWidth: MediaQuery.of(context).size.width,
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      onPressed: () {
        if ((_formKey.currentState.validate())) {
          context.read<AuthCubit>().logIn(
                username: _loginController.text,
                password: _passwordController.text,
              );
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Builder(
        builder: (context) {
          final loginState = context.watch<AuthCubit>().state;

          return loginState is AuthLoginInProgress
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text(
                  "Log in",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kanban"),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginFailure)
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMesage),
                duration: Duration(seconds: 10),
              ),
            );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLoginField(),
                  SizedBox(height: 16),
                  _buildPasswordField(),
                  SizedBox(height: 16),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
