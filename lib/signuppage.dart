import 'package:flutter/material.dart';
import 'package:project/class.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 130,
                child: Image.asset('images/logo.png'),
              ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 36
                  )
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please make an account to login.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                  )
                ),
              ),
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
                    const Icon(Icons.account_circle),
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
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none, 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          border: InputBorder.none, 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)
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
                  if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Username and password must be filled'))
                    );
                    return;
                  }
                  if (users.containsKey(username)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Username already exists'))
                    );
                    return;
                  }
                  users[username] = password;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign up successful! You can now log in.'))
                  );
                  Navigator.pop(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: const Text('Sign up'), 
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {Navigator.pop(context, MaterialPageRoute(builder: (context) => const SignupPage()));},
                  child: const Text('Log in'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}