import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCachedUser {
  final UserRepository repository;
  GetCachedUser(this.repository);
  Future<UserEntity?> call() => repository.getLastLocalUser();
}