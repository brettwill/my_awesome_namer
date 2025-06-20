import 'package:flutter/material.dart';
import 'package:namer_app/helpers/safe_image.dart';
import 'package:url_launcher/url_launcher.dart';

class DogProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String profileUrl;
  final String birthDate;
  final String age;
  final String breed;
  final String gender;
  final String weight;
  final String height;
  final String location;
  final bool isSelected;
  final VoidCallback onTap;

  const DogProfileCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.profileUrl,
    required this.birthDate,
    required this.age,
    required this.breed,
    required this.gender,
    required this.weight,
    required this.height,
    required this.location,
    required this.isSelected,
    required this.onTap,
  });

  void _launchURL() async {
    if (await canLaunch(profileUrl)) {
      await launch(profileUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.lightBlue[50] : null,
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image on the left
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SafeImage(imagePath: imageUrl, height: 120, width: 120),
              ),

              SizedBox(width: 16),
              // Info on the right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _launchURL,
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    _infoRow(Icons.cake, "Birth Date: $birthDate"),
                    _infoRow(Icons.access_time, "Age: $age"),
                    _infoRow(Icons.pets, "Breed: $breed"),
                    _infoRow(Icons.transgender, "Gender: $gender"),
                    _infoRow(Icons.monitor_weight, "Weight: $weight"),
                    _infoRow(Icons.height, "Height: $height"),
                    _infoRow(Icons.home, "Location: $location"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
