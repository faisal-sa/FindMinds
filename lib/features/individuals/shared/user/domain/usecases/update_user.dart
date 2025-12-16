import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);
  
  Future<void> call(UserEntity user) async {
    await repository.updateRemoteProfile(user);
    await repository.cacheUser(user);          
  }
}