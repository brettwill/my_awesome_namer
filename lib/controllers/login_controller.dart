import 'package:namer_app/services/dog_service.dart';

class LoginController {
  final DogService _repository = DogService();

  Future<bool> login(String username, String password) async {
    return await _repository.authenticateUser(username, password);
  }
}
