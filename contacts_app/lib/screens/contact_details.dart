import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> contact;

  const ContactDetailsScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contact["name"])),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                contact["name"][0],
                style: const TextStyle(fontSize: 31),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              contact["name"],
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
            Text(
              contact["phone"],
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
