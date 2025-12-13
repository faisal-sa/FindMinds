import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CacheUser {
  final UserRepository repository;
  CacheUser(this.repository);
  Future<void> call(UserEntity user) => repository.cacheUser(user);
}