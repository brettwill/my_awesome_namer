import 'package:flutter/material.dart';
import 'package:namer_app/models/dog_profile.dart';
//import 'models/dog.dart'; // Your Dog model
import '../business/dog_provider.dart'; // Your Provider
import 'package:provider/provider.dart';

class DogForm extends StatefulWidget {
  final DogProfile? dog; // If null, it's an insert; otherwise, it's an update

  const DogForm({Key? key, this.dog}) : super(key: key);

  @override
  State<DogForm> createState() => _DogFormState();
}

class _DogFormState extends State<DogForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController imageUrlController;
  late TextEditingController profileUrlController;
  late TextEditingController breedController;
  late TextEditingController genderController;
  late TextEditingController birthDateController;
  late TextEditingController ageController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    final dog = widget.dog;
    nameController = TextEditingController(text: dog?.name ?? '');
    imageUrlController = TextEditingController(text: dog?.imageUrl ?? '');
    profileUrlController = TextEditingController(text: dog?.profileUrl ?? '');
    breedController = TextEditingController(text: dog?.breed ?? '');
    genderController = TextEditingController(text: dog?.gender ?? '');
    birthDateController = TextEditingController(text: dog?.birthDate ?? '');
    ageController = TextEditingController(text: dog?.age ?? '');
    weightController = TextEditingController(text: dog?.weight ?? '');
    heightController = TextEditingController(text: dog?.height ?? '');
    locationController = TextEditingController(text: dog?.location ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    profileUrlController.dispose();
    breedController.dispose();
    genderController.dispose();
    birthDateController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final dog = DogProfile(
        id: widget.dog?.id ?? '', // Empty for insert
        name: nameController.text,
        imageUrl: imageUrlController.text,
        profileUrl: profileUrlController.text,
        breed: breedController.text,
        gender: genderController.text,
        birthDate: birthDateController.text,
        age: ageController.text,
        weight: weightController.text,
        height: heightController.text,
        location: locationController.text,
        createdAt: widget.dog?.createdAt,
      );

      final provider = Provider.of<DogProvider>(context, listen: false);
      if (widget.dog == null) {
        provider.addDog(dog);
      } else {
        provider.updateDog(dog);
      }

      Navigator.pop(context);
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: required
          ? (value) => value == null || value.isEmpty ? 'Required' : null
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.dog != null;

    return Scaffold(
      appBar: AppBar(title: Text(isUpdate ? 'Update Dog' : 'Add Dog')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Name', nameController, required: true),
              _buildTextField('Image URL', imageUrlController, required: true),
              _buildTextField(
                'Profile URL',
                profileUrlController,
                required: true,
              ),
              _buildTextField('Breed', breedController),
              _buildTextField('Gender', genderController),
              _buildTextField('Birth Date', birthDateController),
              _buildTextField('Age', ageController),
              _buildTextField('Weight', weightController),
              _buildTextField('Height', heightController),
              _buildTextField('Location', locationController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(isUpdate ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
