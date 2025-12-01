import 'package:flutter/material.dart';
import '../services/contact_api.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final phone = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Contact")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              child: const Text("Save"),
              onPressed: () async {
                if (name.text.isEmpty || phone.text.isEmpty) return;

                final res = await ContactAPI().addContact(
                  name.text,
                  phone.text,
                  null,
                );

                Navigator.pop(context, res);
              },
            ),
          ],
        ),
      ),
    );
  }
}
