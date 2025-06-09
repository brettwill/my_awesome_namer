class DogProfile {
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

  DogProfile({
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
  });

  factory DogProfile.fromMap(Map<String, dynamic> map) {
    return DogProfile(
      name: map['name'],
      imageUrl: map['image_url'],
      profileUrl: map['profile_url'],
      birthDate: map['birth_date'],
      age: map['age'],
      breed: map['breed'],
      gender: map['gender'],
      weight: map['weight'],
      height: map['height'],
      location: map['location'],
    );
  }
}
