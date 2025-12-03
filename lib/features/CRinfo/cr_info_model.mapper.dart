// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cr_info_model.dart';

class CrInfoModelMapper extends ClassMapperBase<CrInfoModel> {
  CrInfoModelMapper._();

  static CrInfoModelMapper? _instance;
  static CrInfoModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CrInfoModelMapper._());
      EntityTypeMapper.ensureInitialized();
      StatusMapper.ensureInitialized();
      ActivityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CrInfoModel';

  static String _$crNationalNumber(CrInfoModel v) => v.crNationalNumber;
  static const Field<CrInfoModel, String> _f$crNationalNumber = Field(
    'crNationalNumber',
    _$crNationalNumber,
  );
  static String _$crNumber(CrInfoModel v) => v.crNumber;
  static const Field<CrInfoModel, String> _f$crNumber = Field(
    'crNumber',
    _$crNumber,
  );
  static int _$versionNo(CrInfoModel v) => v.versionNo;
  static const Field<CrInfoModel, int> _f$versionNo = Field(
    'versionNo',
    _$versionNo,
  );
  static String _$name(CrInfoModel v) => v.name;
  static const Field<CrInfoModel, String> _f$name = Field('name', _$name);
  static int _$duration(CrInfoModel v) => v.duration;
  static const Field<CrInfoModel, int> _f$duration = Field(
    'duration',
    _$duration,
  );
  static bool _$isMain(CrInfoModel v) => v.isMain;
  static const Field<CrInfoModel, bool> _f$isMain = Field('isMain', _$isMain);
  static String _$issueDateGregorian(CrInfoModel v) => v.issueDateGregorian;
  static const Field<CrInfoModel, String> _f$issueDateGregorian = Field(
    'issueDateGregorian',
    _$issueDateGregorian,
  );
  static String _$issueDateHijri(CrInfoModel v) => v.issueDateHijri;
  static const Field<CrInfoModel, String> _f$issueDateHijri = Field(
    'issueDateHijri',
    _$issueDateHijri,
  );
  static String? _$mainCrNationalNumber(CrInfoModel v) =>
      v.mainCrNationalNumber;
  static const Field<CrInfoModel, String> _f$mainCrNationalNumber = Field(
    'mainCrNationalNumber',
    _$mainCrNationalNumber,
    opt: true,
  );
  static String? _$mainCrNumber(CrInfoModel v) => v.mainCrNumber;
  static const Field<CrInfoModel, String> _f$mainCrNumber = Field(
    'mainCrNumber',
    _$mainCrNumber,
    opt: true,
  );
  static bool _$inLiquidationProcess(CrInfoModel v) => v.inLiquidationProcess;
  static const Field<CrInfoModel, bool> _f$inLiquidationProcess = Field(
    'inLiquidationProcess',
    _$inLiquidationProcess,
  );
  static bool _$hasEcommerce(CrInfoModel v) => v.hasEcommerce;
  static const Field<CrInfoModel, bool> _f$hasEcommerce = Field(
    'hasEcommerce',
    _$hasEcommerce,
  );
  static int _$headquarterCityId(CrInfoModel v) => v.headquarterCityId;
  static const Field<CrInfoModel, int> _f$headquarterCityId = Field(
    'headquarterCityId',
    _$headquarterCityId,
  );
  static String _$headquarterCityName(CrInfoModel v) => v.headquarterCityName;
  static const Field<CrInfoModel, String> _f$headquarterCityName = Field(
    'headquarterCityName',
    _$headquarterCityName,
  );
  static bool _$isLicenseBased(CrInfoModel v) => v.isLicenseBased;
  static const Field<CrInfoModel, bool> _f$isLicenseBased = Field(
    'isLicenseBased',
    _$isLicenseBased,
  );
  static EntityType _$entityType(CrInfoModel v) => v.entityType;
  static const Field<CrInfoModel, EntityType> _f$entityType = Field(
    'entityType',
    _$entityType,
  );
  static Status _$status(CrInfoModel v) => v.status;
  static const Field<CrInfoModel, Status> _f$status = Field('status', _$status);
  static List<Activity> _$activities(CrInfoModel v) => v.activities;
  static const Field<CrInfoModel, List<Activity>> _f$activities = Field(
    'activities',
    _$activities,
  );

  @override
  final MappableFields<CrInfoModel> fields = const {
    #crNationalNumber: _f$crNationalNumber,
    #crNumber: _f$crNumber,
    #versionNo: _f$versionNo,
    #name: _f$name,
    #duration: _f$duration,
    #isMain: _f$isMain,
    #issueDateGregorian: _f$issueDateGregorian,
    #issueDateHijri: _f$issueDateHijri,
    #mainCrNationalNumber: _f$mainCrNationalNumber,
    #mainCrNumber: _f$mainCrNumber,
    #inLiquidationProcess: _f$inLiquidationProcess,
    #hasEcommerce: _f$hasEcommerce,
    #headquarterCityId: _f$headquarterCityId,
    #headquarterCityName: _f$headquarterCityName,
    #isLicenseBased: _f$isLicenseBased,
    #entityType: _f$entityType,
    #status: _f$status,
    #activities: _f$activities,
  };

  static CrInfoModel _instantiate(DecodingData data) {
    return CrInfoModel(
      crNationalNumber: data.dec(_f$crNationalNumber),
      crNumber: data.dec(_f$crNumber),
      versionNo: data.dec(_f$versionNo),
      name: data.dec(_f$name),
      duration: data.dec(_f$duration),
      isMain: data.dec(_f$isMain),
      issueDateGregorian: data.dec(_f$issueDateGregorian),
      issueDateHijri: data.dec(_f$issueDateHijri),
      mainCrNationalNumber: data.dec(_f$mainCrNationalNumber),
      mainCrNumber: data.dec(_f$mainCrNumber),
      inLiquidationProcess: data.dec(_f$inLiquidationProcess),
      hasEcommerce: data.dec(_f$hasEcommerce),
      headquarterCityId: data.dec(_f$headquarterCityId),
      headquarterCityName: data.dec(_f$headquarterCityName),
      isLicenseBased: data.dec(_f$isLicenseBased),
      entityType: data.dec(_f$entityType),
      status: data.dec(_f$status),
      activities: data.dec(_f$activities),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CrInfoModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CrInfoModel>(map);
  }

  static CrInfoModel fromJson(String json) {
    return ensureInitialized().decodeJson<CrInfoModel>(json);
  }
}

mixin CrInfoModelMappable {
  String toJson() {
    return CrInfoModelMapper.ensureInitialized().encodeJson<CrInfoModel>(
      this as CrInfoModel,
    );
  }

  Map<String, dynamic> toMap() {
    return CrInfoModelMapper.ensureInitialized().encodeMap<CrInfoModel>(
      this as CrInfoModel,
    );
  }

  CrInfoModelCopyWith<CrInfoModel, CrInfoModel, CrInfoModel> get copyWith =>
      _CrInfoModelCopyWithImpl<CrInfoModel, CrInfoModel>(
        this as CrInfoModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CrInfoModelMapper.ensureInitialized().stringifyValue(
      this as CrInfoModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CrInfoModelMapper.ensureInitialized().equalsValue(
      this as CrInfoModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CrInfoModelMapper.ensureInitialized().hashValue(this as CrInfoModel);
  }
}

extension CrInfoModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CrInfoModel, $Out> {
  CrInfoModelCopyWith<$R, CrInfoModel, $Out> get $asCrInfoModel =>
      $base.as((v, t, t2) => _CrInfoModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CrInfoModelCopyWith<$R, $In extends CrInfoModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  EntityTypeCopyWith<$R, EntityType, EntityType> get entityType;
  StatusCopyWith<$R, Status, Status> get status;
  ListCopyWith<$R, Activity, ActivityCopyWith<$R, Activity, Activity>>
  get activities;
  $R call({
    String? crNationalNumber,
    String? crNumber,
    int? versionNo,
    String? name,
    int? duration,
    bool? isMain,
    String? issueDateGregorian,
    String? issueDateHijri,
    String? mainCrNationalNumber,
    String? mainCrNumber,
    bool? inLiquidationProcess,
    bool? hasEcommerce,
    int? headquarterCityId,
    String? headquarterCityName,
    bool? isLicenseBased,
    EntityType? entityType,
    Status? status,
    List<Activity>? activities,
  });
  CrInfoModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CrInfoModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CrInfoModel, $Out>
    implements CrInfoModelCopyWith<$R, CrInfoModel, $Out> {
  _CrInfoModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CrInfoModel> $mapper =
      CrInfoModelMapper.ensureInitialized();
  @override
  EntityTypeCopyWith<$R, EntityType, EntityType> get entityType =>
      $value.entityType.copyWith.$chain((v) => call(entityType: v));
  @override
  StatusCopyWith<$R, Status, Status> get status =>
      $value.status.copyWith.$chain((v) => call(status: v));
  @override
  ListCopyWith<$R, Activity, ActivityCopyWith<$R, Activity, Activity>>
  get activities => ListCopyWith(
    $value.activities,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(activities: v),
  );
  @override
  $R call({
    String? crNationalNumber,
    String? crNumber,
    int? versionNo,
    String? name,
    int? duration,
    bool? isMain,
    String? issueDateGregorian,
    String? issueDateHijri,
    Object? mainCrNationalNumber = $none,
    Object? mainCrNumber = $none,
    bool? inLiquidationProcess,
    bool? hasEcommerce,
    int? headquarterCityId,
    String? headquarterCityName,
    bool? isLicenseBased,
    EntityType? entityType,
    Status? status,
    List<Activity>? activities,
  }) => $apply(
    FieldCopyWithData({
      if (crNationalNumber != null) #crNationalNumber: crNationalNumber,
      if (crNumber != null) #crNumber: crNumber,
      if (versionNo != null) #versionNo: versionNo,
      if (name != null) #name: name,
      if (duration != null) #duration: duration,
      if (isMain != null) #isMain: isMain,
      if (issueDateGregorian != null) #issueDateGregorian: issueDateGregorian,
      if (issueDateHijri != null) #issueDateHijri: issueDateHijri,
      if (mainCrNationalNumber != $none)
        #mainCrNationalNumber: mainCrNationalNumber,
      if (mainCrNumber != $none) #mainCrNumber: mainCrNumber,
      if (inLiquidationProcess != null)
        #inLiquidationProcess: inLiquidationProcess,
      if (hasEcommerce != null) #hasEcommerce: hasEcommerce,
      if (headquarterCityId != null) #headquarterCityId: headquarterCityId,
      if (headquarterCityName != null)
        #headquarterCityName: headquarterCityName,
      if (isLicenseBased != null) #isLicenseBased: isLicenseBased,
      if (entityType != null) #entityType: entityType,
      if (status != null) #status: status,
      if (activities != null) #activities: activities,
    }),
  );
  @override
  CrInfoModel $make(CopyWithData data) => CrInfoModel(
    crNationalNumber: data.get(#crNationalNumber, or: $value.crNationalNumber),
    crNumber: data.get(#crNumber, or: $value.crNumber),
    versionNo: data.get(#versionNo, or: $value.versionNo),
    name: data.get(#name, or: $value.name),
    duration: data.get(#duration, or: $value.duration),
    isMain: data.get(#isMain, or: $value.isMain),
    issueDateGregorian: data.get(
      #issueDateGregorian,
      or: $value.issueDateGregorian,
    ),
    issueDateHijri: data.get(#issueDateHijri, or: $value.issueDateHijri),
    mainCrNationalNumber: data.get(
      #mainCrNationalNumber,
      or: $value.mainCrNationalNumber,
    ),
    mainCrNumber: data.get(#mainCrNumber, or: $value.mainCrNumber),
    inLiquidationProcess: data.get(
      #inLiquidationProcess,
      or: $value.inLiquidationProcess,
    ),
    hasEcommerce: data.get(#hasEcommerce, or: $value.hasEcommerce),
    headquarterCityId: data.get(
      #headquarterCityId,
      or: $value.headquarterCityId,
    ),
    headquarterCityName: data.get(
      #headquarterCityName,
      or: $value.headquarterCityName,
    ),
    isLicenseBased: data.get(#isLicenseBased, or: $value.isLicenseBased),
    entityType: data.get(#entityType, or: $value.entityType),
    status: data.get(#status, or: $value.status),
    activities: data.get(#activities, or: $value.activities),
  );

  @override
  CrInfoModelCopyWith<$R2, CrInfoModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CrInfoModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EntityTypeMapper extends ClassMapperBase<EntityType> {
  EntityTypeMapper._();

  static EntityTypeMapper? _instance;
  static EntityTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EntityTypeMapper._());
      CharacterMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EntityType';

  static int _$id(EntityType v) => v.id;
  static const Field<EntityType, int> _f$id = Field('id', _$id);
  static String _$name(EntityType v) => v.name;
  static const Field<EntityType, String> _f$name = Field('name', _$name);
  static int _$formId(EntityType v) => v.formId;
  static const Field<EntityType, int> _f$formId = Field('formId', _$formId);
  static String _$formName(EntityType v) => v.formName;
  static const Field<EntityType, String> _f$formName = Field(
    'formName',
    _$formName,
  );
  static List<Character> _$characterList(EntityType v) => v.characterList;
  static const Field<EntityType, List<Character>> _f$characterList = Field(
    'characterList',
    _$characterList,
  );

  @override
  final MappableFields<EntityType> fields = const {
    #id: _f$id,
    #name: _f$name,
    #formId: _f$formId,
    #formName: _f$formName,
    #characterList: _f$characterList,
  };

  static EntityType _instantiate(DecodingData data) {
    return EntityType(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      formId: data.dec(_f$formId),
      formName: data.dec(_f$formName),
      characterList: data.dec(_f$characterList),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EntityType fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EntityType>(map);
  }

  static EntityType fromJson(String json) {
    return ensureInitialized().decodeJson<EntityType>(json);
  }
}

mixin EntityTypeMappable {
  String toJson() {
    return EntityTypeMapper.ensureInitialized().encodeJson<EntityType>(
      this as EntityType,
    );
  }

  Map<String, dynamic> toMap() {
    return EntityTypeMapper.ensureInitialized().encodeMap<EntityType>(
      this as EntityType,
    );
  }

  EntityTypeCopyWith<EntityType, EntityType, EntityType> get copyWith =>
      _EntityTypeCopyWithImpl<EntityType, EntityType>(
        this as EntityType,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EntityTypeMapper.ensureInitialized().stringifyValue(
      this as EntityType,
    );
  }

  @override
  bool operator ==(Object other) {
    return EntityTypeMapper.ensureInitialized().equalsValue(
      this as EntityType,
      other,
    );
  }

  @override
  int get hashCode {
    return EntityTypeMapper.ensureInitialized().hashValue(this as EntityType);
  }
}

extension EntityTypeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EntityType, $Out> {
  EntityTypeCopyWith<$R, EntityType, $Out> get $asEntityType =>
      $base.as((v, t, t2) => _EntityTypeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EntityTypeCopyWith<$R, $In extends EntityType, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Character, CharacterCopyWith<$R, Character, Character>>
  get characterList;
  $R call({
    int? id,
    String? name,
    int? formId,
    String? formName,
    List<Character>? characterList,
  });
  EntityTypeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EntityTypeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EntityType, $Out>
    implements EntityTypeCopyWith<$R, EntityType, $Out> {
  _EntityTypeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EntityType> $mapper =
      EntityTypeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Character, CharacterCopyWith<$R, Character, Character>>
  get characterList => ListCopyWith(
    $value.characterList,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(characterList: v),
  );
  @override
  $R call({
    int? id,
    String? name,
    int? formId,
    String? formName,
    List<Character>? characterList,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (formId != null) #formId: formId,
      if (formName != null) #formName: formName,
      if (characterList != null) #characterList: characterList,
    }),
  );
  @override
  EntityType $make(CopyWithData data) => EntityType(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    formId: data.get(#formId, or: $value.formId),
    formName: data.get(#formName, or: $value.formName),
    characterList: data.get(#characterList, or: $value.characterList),
  );

  @override
  EntityTypeCopyWith<$R2, EntityType, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EntityTypeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CharacterMapper extends ClassMapperBase<Character> {
  CharacterMapper._();

  static CharacterMapper? _instance;
  static CharacterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CharacterMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Character';

  static int _$id(Character v) => v.id;
  static const Field<Character, int> _f$id = Field('id', _$id);
  static String _$name(Character v) => v.name;
  static const Field<Character, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<Character> fields = const {#id: _f$id, #name: _f$name};

  static Character _instantiate(DecodingData data) {
    return Character(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static Character fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Character>(map);
  }

  static Character fromJson(String json) {
    return ensureInitialized().decodeJson<Character>(json);
  }
}

mixin CharacterMappable {
  String toJson() {
    return CharacterMapper.ensureInitialized().encodeJson<Character>(
      this as Character,
    );
  }

  Map<String, dynamic> toMap() {
    return CharacterMapper.ensureInitialized().encodeMap<Character>(
      this as Character,
    );
  }

  CharacterCopyWith<Character, Character, Character> get copyWith =>
      _CharacterCopyWithImpl<Character, Character>(
        this as Character,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CharacterMapper.ensureInitialized().stringifyValue(
      this as Character,
    );
  }

  @override
  bool operator ==(Object other) {
    return CharacterMapper.ensureInitialized().equalsValue(
      this as Character,
      other,
    );
  }

  @override
  int get hashCode {
    return CharacterMapper.ensureInitialized().hashValue(this as Character);
  }
}

extension CharacterValueCopy<$R, $Out> on ObjectCopyWith<$R, Character, $Out> {
  CharacterCopyWith<$R, Character, $Out> get $asCharacter =>
      $base.as((v, t, t2) => _CharacterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CharacterCopyWith<$R, $In extends Character, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name});
  CharacterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CharacterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Character, $Out>
    implements CharacterCopyWith<$R, Character, $Out> {
  _CharacterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Character> $mapper =
      CharacterMapper.ensureInitialized();
  @override
  $R call({int? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  Character $make(CopyWithData data) => Character(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  CharacterCopyWith<$R2, Character, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CharacterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class StatusMapper extends ClassMapperBase<Status> {
  StatusMapper._();

  static StatusMapper? _instance;
  static StatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StatusMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Status';

  static int _$id(Status v) => v.id;
  static const Field<Status, int> _f$id = Field('id', _$id);
  static String _$name(Status v) => v.name;
  static const Field<Status, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<Status> fields = const {#id: _f$id, #name: _f$name};

  static Status _instantiate(DecodingData data) {
    return Status(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static Status fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Status>(map);
  }

  static Status fromJson(String json) {
    return ensureInitialized().decodeJson<Status>(json);
  }
}

mixin StatusMappable {
  String toJson() {
    return StatusMapper.ensureInitialized().encodeJson<Status>(this as Status);
  }

  Map<String, dynamic> toMap() {
    return StatusMapper.ensureInitialized().encodeMap<Status>(this as Status);
  }

  StatusCopyWith<Status, Status, Status> get copyWith =>
      _StatusCopyWithImpl<Status, Status>(this as Status, $identity, $identity);
  @override
  String toString() {
    return StatusMapper.ensureInitialized().stringifyValue(this as Status);
  }

  @override
  bool operator ==(Object other) {
    return StatusMapper.ensureInitialized().equalsValue(this as Status, other);
  }

  @override
  int get hashCode {
    return StatusMapper.ensureInitialized().hashValue(this as Status);
  }
}

extension StatusValueCopy<$R, $Out> on ObjectCopyWith<$R, Status, $Out> {
  StatusCopyWith<$R, Status, $Out> get $asStatus =>
      $base.as((v, t, t2) => _StatusCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StatusCopyWith<$R, $In extends Status, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name});
  StatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StatusCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Status, $Out>
    implements StatusCopyWith<$R, Status, $Out> {
  _StatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Status> $mapper = StatusMapper.ensureInitialized();
  @override
  $R call({int? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  Status $make(CopyWithData data) => Status(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  StatusCopyWith<$R2, Status, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StatusCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ActivityMapper extends ClassMapperBase<Activity> {
  ActivityMapper._();

  static ActivityMapper? _instance;
  static ActivityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ActivityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Activity';

  static String _$id(Activity v) => v.id;
  static const Field<Activity, String> _f$id = Field('id', _$id);
  static String _$name(Activity v) => v.name;
  static const Field<Activity, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<Activity> fields = const {#id: _f$id, #name: _f$name};

  static Activity _instantiate(DecodingData data) {
    return Activity(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static Activity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Activity>(map);
  }

  static Activity fromJson(String json) {
    return ensureInitialized().decodeJson<Activity>(json);
  }
}

mixin ActivityMappable {
  String toJson() {
    return ActivityMapper.ensureInitialized().encodeJson<Activity>(
      this as Activity,
    );
  }

  Map<String, dynamic> toMap() {
    return ActivityMapper.ensureInitialized().encodeMap<Activity>(
      this as Activity,
    );
  }

  ActivityCopyWith<Activity, Activity, Activity> get copyWith =>
      _ActivityCopyWithImpl<Activity, Activity>(
        this as Activity,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ActivityMapper.ensureInitialized().stringifyValue(this as Activity);
  }

  @override
  bool operator ==(Object other) {
    return ActivityMapper.ensureInitialized().equalsValue(
      this as Activity,
      other,
    );
  }

  @override
  int get hashCode {
    return ActivityMapper.ensureInitialized().hashValue(this as Activity);
  }
}

extension ActivityValueCopy<$R, $Out> on ObjectCopyWith<$R, Activity, $Out> {
  ActivityCopyWith<$R, Activity, $Out> get $asActivity =>
      $base.as((v, t, t2) => _ActivityCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ActivityCopyWith<$R, $In extends Activity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  ActivityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ActivityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Activity, $Out>
    implements ActivityCopyWith<$R, Activity, $Out> {
  _ActivityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Activity> $mapper =
      ActivityMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  Activity $make(CopyWithData data) => Activity(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  ActivityCopyWith<$R2, Activity, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ActivityCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

