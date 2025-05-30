import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter/theme_notifier.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String _username = '';
  String _password = '';
  String _campusStatus = 'Not Verified';
  String _studentId = 'STU12345'; // Example data
  String _email = 'student@example.com'; // Example data

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    String? username = await storage.read(key: 'username');
    String? password = await storage.read(key: 'password');

    setState(() {
      _username = username ?? 'Unknown';
      _password = password ?? 'Unknown';
      _campusStatus = 'Not Verified'; // Placeholder for now
    });
  }

  Widget _buildProfileTile(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Calming webbing background
        Positioned.fill(
          child: Opacity(
            opacity: 0.05,
            child: Image.asset(
              'assets/webbing_pattern.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () {
                  ThemeNotifier().toggleTheme();
                },
              ),
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(height: 24),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.tealAccent.withOpacity(0.2),
                  child: const Icon(Icons.person, size: 40, color: Colors.tealAccent),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  _username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildProfileTile("Username", _username),
              _buildProfileTile("Password", _password),
              _buildProfileTile("Campus Verification Status", _campusStatus),
              _buildProfileTile("Student ID", _studentId),
              _buildProfileTile("Email", _email),
            ],
          ),
        ),
      ],
    );
  }
}
