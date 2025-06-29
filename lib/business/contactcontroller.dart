import 'package:namer_app/services/contactrepository.dart';

class ContactController {
  final ContactRepository repository = ContactRepository();

  Future<void> submitContactForm({
    required String salutation,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String content,
  }) async {
    try {
      await repository.sendContactData(
        salutation: salutation,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        content: content,
      );
      print('Contact info  sent successfully!');
    } catch (e) {
      print('Error: $e');
    }
  }
}
