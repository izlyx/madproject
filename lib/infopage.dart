import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  final String info;

  const InfoPage({super.key, required this.info});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.info),
        backgroundColor: Colors.blueAccent
      ),
      body: Column(
        children: [
          widget.info == 'Application Info'
          ? 
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 60, 40, 20),
            child: Expanded(
              child: Text(
                'Finos Track is a comprehensive budget-tracking application designed to assist users in managing their personal finances effectively. The app allows users to record expenses by category, monitor spending against their budget, and gain insights into the highest spending areas. With intuitive visualizations, including progress indicators and summaries, Finos Track provides a clear overview of financial status, enabling informed decision-making and promoting responsible financial management.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),   
              )
            ),
          )
          : Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
            child: Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Developer: Finos Solutions\nEmail: support@finostrack.com\nWebsite: www.finostrack.com\nVersion: 1.0.0',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),   
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'images/logo.png',
                    height: 160,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Finos Solutions is dedicated to creating intuitive and reliable financial tools that empower users to manage their personal finances efficiently. For support, inquiries, or feedback, please reach out via email or visit our website.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),   
                  ),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}