import 'package:flutter/material.dart';
import '../database/database.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AppDatabase database;
  final User user;

  ProfileScreen({required this.database, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Profile', style: TextStyle(fontWeight: FontWeight.bold))),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                Text(
                  user.username,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  user.email ?? 'No email',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          _buildMenuItem(Icons.person_outline, 'Edit Profile', () {}),
          _buildMenuItem(Icons.location_on_outlined, 'Addresses', () {}),
          _buildMenuItem(Icons.payment, 'Payment Methods', () {}),
          _buildMenuItem(Icons.notifications_outlined, 'Notifications', () {}),
          _buildMenuItem(Icons.help_outline, 'Help & Support', () {}),
          _buildMenuItem(Icons.info_outline, 'About', () {}),
          SizedBox(height: 16),
          Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(database: database)),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
