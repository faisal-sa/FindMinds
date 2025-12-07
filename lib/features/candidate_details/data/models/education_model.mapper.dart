// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'education_model.dart';

class EducationModelMapper extends ClassMapperBase<EducationModel> {
  EducationModelMapper._();

  static EducationModelMapper? _instance;
  static EducationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EducationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EducationModel';

  static String _$id(EducationModel v) => v.id;
  static const Field<EducationModel, String> _f$id = Field('id', _$id);
  static String _$institutionName(EducationModel v) => v.institutionName;
  static const Field<EducationModel, String> _f$institutionName = Field(
    'institutionName',
    _$institutionName,
    key: r'institution_name',
  );
  static String _$degreeType(EducationModel v) => v.degreeType;
  static const Field<EducationModel, String> _f$degreeType = Field(
    'degreeType',
    _$degreeType,
    key: r'degree_type',
  );
  static String _$fieldOfStudy(EducationModel v) => v.fieldOfStudy;
  static const Field<EducationModel, String> _f$fieldOfStudy = Field(
    'fieldOfStudy',
    _$fieldOfStudy,
    key: r'field_of_study',
  );
  static DateTime _$startDate(EducationModel v) => v.startDate;
  static const Field<EducationModel, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
    key: r'start_date',
  );
  static DateTime? _$endDate(EducationModel v) => v.endDate;
  static const Field<EducationModel, DateTime> _f$endDate = Field(
    'endDate',
    _$endDate,
    key: r'end_date',
    opt: true,
  );

  @override
  final MappableFields<EducationModel> fields = const {
    #id: _f$id,
    #institutionName: _f$institutionName,
    #degreeType: _f$degreeType,
    #fieldOfStudy: _f$fieldOfStudy,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
  };

  static EducationModel _instantiate(DecodingData data) {
    return EducationModel(
      id: data.dec(_f$id),
      institutionName: data.dec(_f$institutionName),
      degreeType: data.dec(_f$degreeType),
      fieldOfStudy: data.dec(_f$fieldOfStudy),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EducationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EducationModel>(map);
  }

  static EducationModel fromJson(String json) {
    return ensureInitialized().decodeJson<EducationModel>(json);
  }
}

mixin EducationModelMappable {
  String toJson() {
    return EducationModelMapper.ensureInitialized().encodeJson<EducationModel>(
      this as EducationModel,
    );
  }

  Map<String, dynamic> toMap() {
    return EducationModelMapper.ensureInitialized().encodeMap<EducationModel>(
      this as EducationModel,
    );
  }

  EducationModelCopyWith<EducationModel, EducationModel, EducationModel>
  get copyWith => _EducationModelCopyWithImpl<EducationModel, EducationModel>(
    this as EducationModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return EducationModelMapper.ensureInitialized().stringifyValue(
      this as EducationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return EducationModelMapper.ensureInitialized().equalsValue(
      this as EducationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return EducationModelMapper.ensureInitialized().hashValue(
      this as EducationModel,
    );
  }
}

extension EducationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EducationModel, $Out> {
  EducationModelCopyWith<$R, EducationModel, $Out> get $asEducationModel =>
      $base.as((v, t, t2) => _EducationModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EducationModelCopyWith<$R, $In extends EducationModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? institutionName,
    String? degreeType,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
  });
  EducationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EducationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EducationModel, $Out>
    implements EducationModelCopyWith<$R, EducationModel, $Out> {
  _EducationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EducationModel> $mapper =
      EducationModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? institutionName,
    String? degreeType,
    String? fieldOfStudy,
    DateTime? startDate,
    Object? endDate = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (institutionName != null) #institutionName: institutionName,
      if (degreeType != null) #degreeType: degreeType,
      if (fieldOfStudy != null) #fieldOfStudy: fieldOfStudy,
      if (startDate != null) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
    }),
  );
  @override
  EducationModel $make(CopyWithData data) => EducationModel(
    id: data.get(#id, or: $value.id),
    institutionName: data.get(#institutionName, or: $value.institutionName),
    degreeType: data.get(#degreeType, or: $value.degreeType),
    fieldOfStudy: data.get(#fieldOfStudy, or: $value.fieldOfStudy),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
  );

  @override
  EducationModelCopyWith<$R2, EducationModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EducationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

