import 'package:flutter/material.dart';
import 'package:project/loginpage.dart';
import 'package:project/class.dart';
import 'navigation.dart';

class ProfilePage extends StatefulWidget {
  final String currentName;

  const ProfilePage({super.key, required this.currentName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.currentName;
  }

  @override
  void dispose() {
    nameController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void updateUsername(String oldName, String newName) {
    if (!users.containsKey(oldName)) return;

    if (users.containsKey(newName)) {
      throw 'Username already exists';
    }

    final password = users[oldName]!;

    users.remove(oldName);
    users[newName] = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Center(
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/login.png')
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
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
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.wallet_travel),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: budgetController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Monthly Budget',
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
                      final newName = nameController.text;
                      final int? budget = int.tryParse(budgetController.text);
                      if (newName.isEmpty) return;
                      try {
                        updateUsername(widget.currentName, newName);
                        if (budget != null) {
                          monthlyBudget = budget;
                        }
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(
                              text: newName,
                              budget: monthlyBudget,
                            ),
                          ),
                        );
                      } 
                      catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: const Text('Save'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
