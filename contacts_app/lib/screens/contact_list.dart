import 'package:flutter/material.dart';
import '../services/contact_api.dart';
import 'add_contact.dart';
import 'edit_contact.dart';
import 'contact_details.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final ContactAPI api = ContactAPI();

  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final data = await api.getContacts();
    setState(() {
      contacts = List<Map<String, dynamic>>.from(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),

      body: contacts.isEmpty
          ? const Center(child: Text("No Contacts Found"))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final c = contacts[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(c["name"][0].toUpperCase()),
                  ),
                  title: Text(c["name"]),
                  subtitle: Text(c["phone"]),

                  // DETAILS
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactDetailsScreen(contact: c),
                      ),
                    );
                  },

                  // EDIT + DELETE
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDIT
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditContactScreen(contact: c),
                            ),
                          );

                          if (updated != null) {
                            loadContacts();
                          }
                        },
                      ),

                      // DELETE
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await api.deleteContact(c["_id"]);
                          loadContacts();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

      // ADD BUTTON
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newContact = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddContactScreen()),
          );

          if (newContact != null) {
            loadContacts();
          }
        },
      ),
    );
  }
}
