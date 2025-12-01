import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactAPI {
  final String baseUrl = "http://10.0.2.2:5000"; // Android Emulator localhost

  // ⚡ Get all contacts
  Future<List<dynamic>> getContacts() async {
    final res = await http.get(Uri.parse("$baseUrl/api/contacts"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load contacts");
    }
  }

  // ⚡ Add contact
  Future<Map<String, dynamic>> addContact(
    String name,
    String phone,
    String? email,
  ) async {
    final body = {"name": name, "phone": phone, "email": email};

    final res = await http.post(
      Uri.parse("$baseUrl/api/contacts"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode == 201) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to add contact");
    }
  }

  // ⚡ Update contact
  Future<Map<String, dynamic>> updateContact(
    String id,
    String name,
    String phone,
    String? email,
  ) async {
    final body = {"name": name, "phone": phone, "email": email};

    final res = await http.put(
      Uri.parse("$baseUrl/api/contacts/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to update contact");
    }
  }

  // ⚡ Delete contact
  Future<bool> deleteContact(String id) async {
    final res = await http.delete(Uri.parse("$baseUrl/api/contacts/$id"));

    return res.statusCode == 200;
  }
}
