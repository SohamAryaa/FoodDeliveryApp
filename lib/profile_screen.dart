import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_profile_screen.dart';
import 'user_api.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: UserApi.getUserData(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final userData = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.displayName}'),
                Text('Email: ${user.email}'),
                Text('Address: ${userData?['address']}'),
                ElevatedButton(
                  onPressed: () {
                    _navigateToEditProfileScreen(context);
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToEditProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
    );
  }
}
