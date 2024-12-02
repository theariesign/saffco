import 'package:flutter/material.dart';

class TipDetailPage extends StatelessWidget {
  final Map<String, String> tip;

  const TipDetailPage({Key? key, required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tip['title']!),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white, // Body background color set to white
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tip['title']!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                tip['description']!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Full Tip Content Here...',
                style: TextStyle(fontSize: 16),
              ),
              // Add more detailed content here
            ],
          ),
        ),
      ),
    );
  }
}
