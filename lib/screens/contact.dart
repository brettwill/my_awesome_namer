import 'package:flutter/material.dart';
import 'package:namer_app/business/contactcontroller.dart';

class KontaktPage extends StatefulWidget {
  @override
  _KontaktPageState createState() => _KontaktPageState();
}

class _KontaktPageState extends State<KontaktPage> {
  final _formKey = GlobalKey<FormState>();
  String? _anrede;
  String _vorname = '';
  String _name = '';
  String _email = '';
  String _telefonnummer = '';
  final ContactController controller = ContactController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kontakt')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mit * gekennzeichnete Felder sind Pflichtfelder.\nWir freuen uns auf Ihre Kontaktaufnahme.',
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Anrede*'),
                value: _anrede,
                items: ['Frau', 'Herr']
                    .map(
                      (label) =>
                          DropdownMenuItem(value: label, child: Text(label)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _anrede = value),
                validator: (value) =>
                    value == null ? 'Bitte Anrede auswählen' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vorname*'),
                onChanged: (value) => _vorname = value,
                validator: (value) =>
                    value!.isEmpty ? 'Vorname ist erforderlich' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name*'),
                onChanged: (value) => _name = value,
                validator: (value) =>
                    value!.isEmpty ? 'Name ist erforderlich' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-Mail*'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _email = value,
                validator: (value) =>
                    value!.isEmpty ? 'E-Mail ist erforderlich' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefonnummer*'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => _telefonnummer = value,
                validator: (value) =>
                    value!.isEmpty ? 'Telefonnummer ist erforderlich' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit logic here
                    controller.submitContactForm(
                      anrede: _anrede!,
                      vorname: _vorname,
                      name: _name,
                      email: _email,
                      telefonnummer: _telefonnummer,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Formular erfolgreich gesendet!')),
                    );
                  }
                },
                child: Text('Absenden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
