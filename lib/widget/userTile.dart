import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.username, required this.image, required this.role_id});
  final String username;
  final String image;
  final int role_id;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      padding: EdgeInsets.all(16.0),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Image
          Image.asset(
            'lib/assets/1.png',
            width: 60, // Adjust width as needed
            height: 60, // Adjust height as needed
            fit: BoxFit
                .cover, // Adjust how the image is displayed within the box
          ),
          SizedBox(width: 16.0), // Add spacing between image and text

          // Right side: Name and Role
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0), // Add spacing between name and role
              Text(
                role_id.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}



