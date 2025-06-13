import '../models/dog_profile.dart';
import '../services/dog_service.dart';

class DogController {
  final DogService _dogService = DogService();

  Future<List<DogProfile>> getAllDogs() => _dogService.fetchDogs();

  Future<List<DogProfile>> getUserDogs(String userId) =>
      _dogService.fetchDogsByUserId(userId);

  Future<void> assignDog(String userId, String dogId) =>
      _dogService.assignDogToUser(userId, dogId);

  Future<void> removeDog(String userId, String dogId) =>
      _dogService.removeDogFromUser(userId, dogId);
}
