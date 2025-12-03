import 'package:dart_mappable/dart_mappable.dart';

part 'cr_info_model.mapper.dart';

@MappableClass()
class CrInfoModel with CrInfoModelMappable {
  final String crNationalNumber;
  final String crNumber;
  final int versionNo;
  final String name;
  final int duration;
  final bool isMain;
  final String issueDateGregorian;
  final String issueDateHijri;
  final String? mainCrNationalNumber;
  final String? mainCrNumber;
  final bool inLiquidationProcess;
  final bool hasEcommerce;
  final int headquarterCityId;
  final String headquarterCityName;
  final bool isLicenseBased;
  final EntityType entityType;
  final Status status;
  final List<Activity> activities;

  CrInfoModel({
    required this.crNationalNumber,
    required this.crNumber,
    required this.versionNo,
    required this.name,
    required this.duration,
    required this.isMain,
    required this.issueDateGregorian,
    required this.issueDateHijri,
    this.mainCrNationalNumber,
    this.mainCrNumber,
    required this.inLiquidationProcess,
    required this.hasEcommerce,
    required this.headquarterCityId,
    required this.headquarterCityName,
    required this.isLicenseBased,
    required this.entityType,
    required this.status,
    required this.activities,
  });
}

@MappableClass()
class EntityType with EntityTypeMappable {
  final int id;
  final String name;
  final int formId;
  final String formName;
  final List<Character> characterList;

  EntityType({
    required this.id,
    required this.name,
    required this.formId,
    required this.formName,
    required this.characterList,
  });
}

@MappableClass()
class Character with CharacterMappable {
  final int id;
  final String name;

  Character({required this.id, required this.name});
}

@MappableClass()
class Status with StatusMappable {
  final int id;
  final String name;

  Status({required this.id, required this.name});
}

@MappableClass()
class Activity with ActivityMappable {
  final String id;
  final String name;

  Activity({required this.id, required this.name});
}
