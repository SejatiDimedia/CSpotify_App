import 'package:cspotify_app/common/widgets/appbar/app_bar.dart';
import 'package:cspotify_app/common/widgets/button/basic_app_button.dart';
import 'package:cspotify_app/core/configs/assets/app_vectors.dart';
import 'package:cspotify_app/data/models/auth/create_user_req.dart';
import 'package:cspotify_app/domain/usecases/auth/signup_usecase.dart';
import 'package:cspotify_app/presentation/auth/pages/signin_page.dart';
import 'package:cspotify_app/presentation/root/pages/root_page.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(
                height: 40,
              ),
              _fullNameField(context),
              const SizedBox(
                height: 20,
              ),
              _emailField(context),
              const SizedBox(
                height: 20,
              ),
              _passwordField(context),
              const SizedBox(
                height: 20,
              ),
              BasicAppButton(
                  onPressed: () async {
                    var result = await sl<SignupUsecase>().call(
                      params: CreateUserReq(
                        fullName: _fullName.text.toString(),
                        email: _email.text.toString(),
                        password: _password.text.toString(),
                      ),
                    );
                    result.fold((l) {
                      var snackbar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }, (r) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RootPage()),
                        (route) => false,
                      );
                    });
                  },
                  title: 'Create Account')
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Sign Up",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: 'Enter Full Name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
        hintText: 'Enter Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Do you have an account?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SigninPage(),
                ),
              );
            },
            child: const Text("Sign In"),
          )
        ],
      ),
    );
  }
}