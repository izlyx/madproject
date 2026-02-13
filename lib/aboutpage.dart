import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'infopage.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.blueAccent
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'images/logo.png',
              height: 160,
            ),
            const Text(
              'Finos Track',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
              child: SizedBox(
                height: 50,
                width: 270,
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),)
                    ),
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoPage(info: 'Application Info')));},
                    child: const Text(
                      'Application Info',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: SizedBox(
                height: 50,
                width: 270,
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),)
                    ),
                    onPressed: () async {
                      final Uri whatsapp = Uri.parse('https://wa.me/87654321');
                      if (await canLaunchUrl(whatsapp)) {
                        await launchUrl(
                          whatsapp,
                          mode: LaunchMode.externalApplication,
                        );
                      } 
                      else {
                        throw 'Cannot launch $whatsapp';
                      }
                    },
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: SizedBox(
                height: 50,
                width: 270,
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),)
                    ),
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoPage(info: 'Developer Info')));},
                    child: const Text(
                      'Developer Info',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook, size: 40, color: Colors.blue),
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.facebook.com');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } 
                      else {
                        throw 'Cannot launch $url';
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.email, size: 40, color: Colors.blue),
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.gmail.com');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } 
                      else {
                        throw 'Cannot launch $url';
                      }
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram, size: 40, color: Colors.blue),
                    onPressed: () async {
                      final Uri url = Uri.parse('https://www.instagram.com');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } 
                      else {
                        throw 'Cannot launch $url';
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}