import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/routes/app_routes.dart';
import 'package:sahayatri/core/common/snackbar/my_snackbar.dart';
import 'package:sahayatri/features/auth/presentation/viewmodel/login_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final key = GlobalKey<FormState>();
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(loginViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userState.showMessage! && userState.error != null) {
        showSnackBar(message: 'Invalid Credentials', context: context);
        ref.read(loginViewModelProvider.notifier).resetMessage();
      }
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.612),
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(63, 233, 229, 229),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(40, 138, 137, 137),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: key,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: const ValueKey('email'),
                                  controller: firstController,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: secondController,
                                  obscureText: isObscure,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          isObscure = !isObscure;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (key.currentState!.validate()) {
                                      await ref
                                          .read(loginViewModelProvider.notifier)
                                          .loginUser(
                                            context,
                                            firstController.text,
                                            secondController.text,
                                          );
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 33, 45, 55),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text("Login"),
                                ),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Don't have an account?"),
                                      GestureDetector(
                                        child: const Text(
                                          "Register Now",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, AppRoute.signUpRoute);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
