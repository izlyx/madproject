import 'package:flutter/material.dart';
import 'package:project/navigation.dart';
import 'package:project/class.dart';


import 'signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Finos Track',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  )
                ),
                Image.asset(
                  'images/logo.png',
                  height: 180,
                ),
                const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 36
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please Log in to continue.',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none, 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 40),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lock),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 310,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      String username = nameController.text;
                      String password = passwordController.text;
                      if (users.containsKey(username) && users[username] == password) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(text: username, budget: monthlyBudget),
                          ),
                        );
                      } 
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid username or password')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Log In'),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));},
                      child: const Text('Sign up'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}