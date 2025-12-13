import 'package:graduation_project/features/individuals/profile/routes/basic_info/domain/entities/basic_info_entity.dart';

abstract class BasicInfoRepository {
  Future<void> saveBasicInfo(BasicInfoEntity basicInfo);
}
