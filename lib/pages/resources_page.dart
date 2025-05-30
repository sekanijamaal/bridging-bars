import 'package:flutter/material.dart';
import 'package:starter/theme_notifier.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  final List<Map<String, String>> resources = const [
    {
      "name": "Dr. Ada Agyemang",
      "role": "Mentor - Stress Management",
      "contact": "ada.mentor@example.com"
    },
    {
      "name": "Mr. Kwame Mensah",
      "role": "Counselor - Academic Support",
      "contact": "kwame.counselor@example.com"
    },
    {
      "name": "Mrs. Lucy Boateng",
      "role": "Mentor - Mental Health",
      "contact": "lucy.mentor@example.com"
    },
  ];

  Widget _buildResourceTile(String name, String role, String contact) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/mentor_avatar.png'),
          backgroundColor: Colors.tealAccent,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          "$role\nContact: $contact",
          style: const TextStyle(color: Colors.grey),
        ),
        isThreeLine: true,
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
            title: const Text("Resources"),
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
            children: resources.map((resource) {
              return _buildResourceTile(
                resource["name"]!,
                resource["role"]!,
                resource["contact"]!,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
