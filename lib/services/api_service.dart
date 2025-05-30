import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://bridging-bars.onrender.com'; // your live backend

  // Student login
  static Future<bool> login(String identifier, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'identifier': identifier, 'password': password}),
    );
    return response.statusCode == 200;
  }

  // Student signup
  static Future<bool> signup(
      String name, String identifier, String password, File profileImage) async {
    var request =
    http.MultipartRequest('POST', Uri.parse('$baseUrl/signup'));
    request.fields['name'] = name;
    request.fields['identifier'] = identifier;
    request.fields['password'] = password;
    request.files
        .add(await http.MultipartFile.fromPath('profile_image', profileImage.path));

    var response = await request.send();
    return response.statusCode == 200;
  }

  // Send chat message
  static Future<void> sendMessage(
      int conversationId, int senderId, String text) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send-message'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'conversation_id': conversationId,
        'sender_id': senderId,
        'text': text,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

  // Get chat messages
  static Future<List<dynamic>> getMessages(int conversationId) async {
    final response =
    await http.get(Uri.parse('$baseUrl/messages/$conversationId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
