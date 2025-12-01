import 'package:flutter/material.dart';
import '../services/contact_api.dart';

class EditContactScreen extends StatefulWidget {
  final Map<String, dynamic> contact;

  const EditContactScreen({super.key, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final ContactAPI api = ContactAPI();

  late TextEditingController name;
  late TextEditingController phone;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.contact["name"]);
    phone = TextEditingController(text: widget.contact["phone"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Contact")),

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
            const SizedBox(height: 15),

            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              child: const Text("Update"),
              onPressed: () async {
                await api.updateContact(
                  widget.contact["_id"],
                  name.text,
                  phone.text,
                  null,
                );

                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
