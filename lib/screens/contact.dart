import 'package:flutter/material.dart';
import 'package:namer_app/business/contactcontroller.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  String? _salutation;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  final ContactController controller = ContactController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fields marked with * are required.\nWe look forward to hearing from you.',
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Title*'),
                value: _salutation,
                items: ['Ms.', 'Mr.']
                    .map(
                      (label) =>
                          DropdownMenuItem(value: label, child: Text(label)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _salutation = value),
                validator: (value) =>
                    value == null ? 'Please select a Title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name*'),
                onChanged: (value) => _firstName = value,
                validator: (value) =>
                    value!.isEmpty ? 'First name is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name*'),
                onChanged: (value) => _lastName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Last name is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email*'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _email = value,
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number*'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => _phoneNumber = value,
                validator: (value) =>
                    value!.isEmpty ? 'Phone number is required' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.submitContactForm(
                      anrede: _salutation!,
                      vorname: _firstName,
                      name: _lastName,
                      email: _email,
                      telefonnummer: _phoneNumber,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully!')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
