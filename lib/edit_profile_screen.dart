import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_api.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final userData = await UserApi.getUserData(widget.user.uid);
    if (userData != null) {
      _addressController.text = userData['address'];
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _saveProfile();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() async {
    final String address = _addressController.text.trim();

    if (address.isNotEmpty) {
      await UserApi.updateUserData(widget.user.uid, {'address': address});
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter your address.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
