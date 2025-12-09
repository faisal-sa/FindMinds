// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'work_experience_model.dart';

class WorkExperienceModelMapper extends ClassMapperBase<WorkExperienceModel> {
  WorkExperienceModelMapper._();

  static WorkExperienceModelMapper? _instance;
  static WorkExperienceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorkExperienceModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WorkExperienceModel';

  static String _$id(WorkExperienceModel v) => v.id;
  static const Field<WorkExperienceModel, String> _f$id = Field('id', _$id);
  static String _$jobTitle(WorkExperienceModel v) => v.jobTitle;
  static const Field<WorkExperienceModel, String> _f$jobTitle = Field(
    'jobTitle',
    _$jobTitle,
    key: r'job_title',
  );
  static String _$companyName(WorkExperienceModel v) => v.companyName;
  static const Field<WorkExperienceModel, String> _f$companyName = Field(
    'companyName',
    _$companyName,
    key: r'company_name',
  );
  static String _$location(WorkExperienceModel v) => v.location;
  static const Field<WorkExperienceModel, String> _f$location = Field(
    'location',
    _$location,
  );
  static DateTime _$startDate(WorkExperienceModel v) => v.startDate;
  static const Field<WorkExperienceModel, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
    key: r'start_date',
  );
  static DateTime? _$endDate(WorkExperienceModel v) => v.endDate;
  static const Field<WorkExperienceModel, DateTime> _f$endDate = Field(
    'endDate',
    _$endDate,
    key: r'end_date',
    opt: true,
  );
  static bool _$isCurrentlyWorking(WorkExperienceModel v) =>
      v.isCurrentlyWorking;
  static const Field<WorkExperienceModel, bool> _f$isCurrentlyWorking = Field(
    'isCurrentlyWorking',
    _$isCurrentlyWorking,
    key: r'is_currently_working',
  );
  static String? _$description(WorkExperienceModel v) => v.description;
  static const Field<WorkExperienceModel, String> _f$description = Field(
    'description',
    _$description,
    key: r'responsibilities',
    opt: true,
  );

  @override
  final MappableFields<WorkExperienceModel> fields = const {
    #id: _f$id,
    #jobTitle: _f$jobTitle,
    #companyName: _f$companyName,
    #location: _f$location,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #isCurrentlyWorking: _f$isCurrentlyWorking,
    #description: _f$description,
  };

  static WorkExperienceModel _instantiate(DecodingData data) {
    return WorkExperienceModel(
      id: data.dec(_f$id),
      jobTitle: data.dec(_f$jobTitle),
      companyName: data.dec(_f$companyName),
      location: data.dec(_f$location),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      isCurrentlyWorking: data.dec(_f$isCurrentlyWorking),
      description: data.dec(_f$description),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WorkExperienceModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorkExperienceModel>(map);
  }

  static WorkExperienceModel fromJson(String json) {
    return ensureInitialized().decodeJson<WorkExperienceModel>(json);
  }
}

mixin WorkExperienceModelMappable {
  String toJson() {
    return WorkExperienceModelMapper.ensureInitialized()
        .encodeJson<WorkExperienceModel>(this as WorkExperienceModel);
  }

  Map<String, dynamic> toMap() {
    return WorkExperienceModelMapper.ensureInitialized()
        .encodeMap<WorkExperienceModel>(this as WorkExperienceModel);
  }

  WorkExperienceModelCopyWith<
    WorkExperienceModel,
    WorkExperienceModel,
    WorkExperienceModel
  >
  get copyWith =>
      _WorkExperienceModelCopyWithImpl<
        WorkExperienceModel,
        WorkExperienceModel
      >(this as WorkExperienceModel, $identity, $identity);
  @override
  String toString() {
    return WorkExperienceModelMapper.ensureInitialized().stringifyValue(
      this as WorkExperienceModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return WorkExperienceModelMapper.ensureInitialized().equalsValue(
      this as WorkExperienceModel,
      other,
    );
  }

  @override
  int get hashCode {
    return WorkExperienceModelMapper.ensureInitialized().hashValue(
      this as WorkExperienceModel,
    );
  }
}

extension WorkExperienceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorkExperienceModel, $Out> {
  WorkExperienceModelCopyWith<$R, WorkExperienceModel, $Out>
  get $asWorkExperienceModel => $base.as(
    (v, t, t2) => _WorkExperienceModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WorkExperienceModelCopyWith<
  $R,
  $In extends WorkExperienceModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? jobTitle,
    String? companyName,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
    String? description,
  });
  WorkExperienceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WorkExperienceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorkExperienceModel, $Out>
    implements WorkExperienceModelCopyWith<$R, WorkExperienceModel, $Out> {
  _WorkExperienceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorkExperienceModel> $mapper =
      WorkExperienceModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? jobTitle,
    String? companyName,
    String? location,
    DateTime? startDate,
    Object? endDate = $none,
    bool? isCurrentlyWorking,
    Object? description = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (jobTitle != null) #jobTitle: jobTitle,
      if (companyName != null) #companyName: companyName,
      if (location != null) #location: location,
      if (startDate != null) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (isCurrentlyWorking != null) #isCurrentlyWorking: isCurrentlyWorking,
      if (description != $none) #description: description,
    }),
  );
  @override
  WorkExperienceModel $make(CopyWithData data) => WorkExperienceModel(
    id: data.get(#id, or: $value.id),
    jobTitle: data.get(#jobTitle, or: $value.jobTitle),
    companyName: data.get(#companyName, or: $value.companyName),
    location: data.get(#location, or: $value.location),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    isCurrentlyWorking: data.get(
      #isCurrentlyWorking,
      or: $value.isCurrentlyWorking,
    ),
    description: data.get(#description, or: $value.description),
  );

  @override
  WorkExperienceModelCopyWith<$R2, WorkExperienceModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WorkExperienceModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

