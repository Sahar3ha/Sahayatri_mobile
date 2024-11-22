import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/routes/app_routes.dart';
import 'package:sahayatri/features/auth/domain/entity/user_entity.dart';
import 'package:sahayatri/features/auth/presentation/viewmodel/user_view_model.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final key = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Signup.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.612),
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    height: 500,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(63, 233, 229, 229),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(40, 138, 137, 137),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0, 0))
                        ]),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextFormField(
                            controller: fnameController,
                            decoration: const InputDecoration(
                                labelText: "First Name",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextFormField(
                            controller: lnameController,
                            decoration: const InputDecoration(
                                labelText: "Last Name",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                labelText: "Password",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: SizedBox(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () {
                                UserEntity user = UserEntity(
                                    firstName: fnameController.text,
                                    lastName: lnameController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                                ref
                                    .read(userViewModelProvider.notifier)
                                    .addUser(user);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 33, 45, 55)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: const Text("SignUp"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.loginRoute);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
