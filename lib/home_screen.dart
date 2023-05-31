import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_screen.dart';
import 'chatgpt_api.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.displayName}!'),
            ElevatedButton(
              onPressed: () {
                _navigateToProfileScreen(context);
              },
              child: Text('View Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                _recommendFood(context);
              },
              child: Text('Recommend Food'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
    );
  }

  void _recommendFood(BuildContext context) {
    // Call the ChatGPT API to get food recommendations based on user preferences
    // You'll need to implement this functionality using the API documentation
    // and handle the response accordingly
    ChatGptApi.getFoodRecommendations(user.uid).then((recommendations) {
      // Display the food recommendations in a dialog or navigate to a new screen
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Food Recommendations'),
            content: Text(recommendations),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      print('Failed to get food recommendations: $error');
    });
  }
}
