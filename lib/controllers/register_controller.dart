import '../services/dog_service.dart';

class RegisterController {
  final DogService _dogService;

  RegisterController(this._dogService);

  String? validatePasswords(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? resolveTier(String code) {
    switch (code.trim()) {
      case 'TIER1CODE':
        return 'Basic';
      case 'TIER2CODE':
        return 'Premium';
      case 'TIER3CODE':
        return 'Admin';
      default:
        return null;
    }
  }

  Future<Map<String, dynamic>?> registerUser({
    required String username,
    required String password,
    required String tierCode,
  }) async {
    final tier = resolveTier(tierCode);
    if (tier == null) return null;

    return await _dogService.registerUser(
      username: username,
      password: password,
      tierCode: tierCode,
    );
  }
}
