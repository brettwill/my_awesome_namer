class Dog {
  final String id;
  final String name;
  final String imageUrl;
  final String profileUrl;
  final String? birthDate;
  final String? age;
  final String? breed;
  final String? gender;
  final String? weight;
  final String? height;
  final String? location;

  Dog({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.profileUrl,
    this.birthDate,
    this.age,
    this.breed,
    this.gender,
    this.weight,
    this.height,
    this.location,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      profileUrl: json['profile_url'],
      birthDate: json['birth_date'],
      age: json['age'],
      breed: json['breed'],
      gender: json['gender'],
      weight: json['weight'],
      height: json['height'],
      location: json['location'],
    );
  }
}
