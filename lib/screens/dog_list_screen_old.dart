// import 'package:flutter/material.dart';
// import 'package:namer_app/models/dog.dart';
// import 'package:namer_app/services/dog_service.dart';
// import 'dog_detail_screen.dart';

// class DogListScreenEx extends StatefulWidget {
//   @override
//   _DogListScreenExState createState() => _DogListScreenExState();
// }

// class _DogListScreenExState extends State<DogListScreenEx> {
//   final DogService _dogService = DogService();
//   List<Dog> _dogs = [];
//   List<String> _breedOptions = [];

//   final Map<String, String> _filters = {
//     'name': '',
//     'breed': '',
//     'gender': '',
//     'age': '',
//     'location': '',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _loadDogs();
//     _loadBreeds();
//   }

//   void _loadDogs() async {
//     final dogs = await _dogService.fetchDogsWithFilter(filters: _filters);
//     setState(() {
//       _dogs = dogs;
//     });
//   }

//   void _loadBreeds() async {
//     final breeds = await _dogService.fetchBreeds();
//     setState(() {
//       _breedOptions = breeds;
//     });
//   }

//   Widget _buildFilterField(String label, String key) {
//     if (key == 'gender') {
//       return _buildDropdownField(label, key, ['Male', 'Female']);
//     } else if (key == 'breed') {
//       return _buildDropdownField(label, key, _breedOptions);
//     } else {
//       return SizedBox(
//         width: MediaQuery.of(context).size.width / 2 - 24,
//         child: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: TextField(
//             decoration: InputDecoration(
//               labelText: label,
//               border: OutlineInputBorder(),
//             ),
//             onChanged: (value) {
//               _filters[key] = value;
//               _loadDogs();
//             },
//           ),
//         ),
//       );
//     }
//   }

//   Widget _buildDropdownField(String label, String key, List<String> options) {
//     final List<String> dropdownOptions = [''] + options;

//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 2 - 24,
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             labelText: label,
//             border: OutlineInputBorder(),
//           ),
//           value: _filters[key]!.isEmpty ? null : _filters[key],
//           items: dropdownOptions.map((option) {
//             return DropdownMenuItem(
//               value: option,
//               child: Text(option.isEmpty ? 'Any' : option),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               _filters[key] = value ?? '';
//               _loadDogs();
//             });
//           },
//           isExpanded: true,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Dog Browser')),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             ExpansionTile(
//               title: Text(
//                 'Filter Dogs',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               childrenPadding: const EdgeInsets.symmetric(
//                 horizontal: 8.0,
//                 vertical: 4.0,
//               ),
//               initiallyExpanded: false,
//               children: [
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: _filters.keys
//                       .map((key) => _buildFilterField(key.capitalize(), key))
//                       .toList(),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Results',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: _dogs.isEmpty
//                   ? Center(child: Text('No dogs found.'))
//                   : ListView.builder(
//                       itemCount: _dogs.length,
//                       itemBuilder: (context, index) {
//                         final dog = _dogs[index];
//                         return Card(
//                           child: ListTile(
//                             title: Text(dog.name),
//                             subtitle: Text(dog.breed ?? 'Unknown breed'),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => DogDetailScreen(dog: dog),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() {
//     return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
//   }
// }
