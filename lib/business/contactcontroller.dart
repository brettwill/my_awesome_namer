import 'package:namer_app/repository/contactrepository.dart';

class ContactController {
  final ContactRepository repository = ContactRepository();

  Future<void> submitContactForm({
    required String anrede,
    required String vorname,
    required String name,
    required String email,
    required String telefonnummer,
  }) async {
    try {
      await repository.sendContactData(
        anrede: anrede,
        vorname: vorname,
        name: name,
        email: email,
        telefonnummer: telefonnummer,
      );
      print('Kontakt erfolgreich gesendet!');
    } catch (e) {
      print('Fehler: $e');
    }
  }
}
