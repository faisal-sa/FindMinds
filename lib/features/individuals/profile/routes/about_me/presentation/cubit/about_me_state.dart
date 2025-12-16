import 'package:equatable/equatable.dart';

enum FormStatus { initial, loading, success, failure }
class AboutMeState extends Equatable {
  final String summary;
  final String? videoPath;
  final String? existingVideoUrl;
  final FormStatus status;

  const AboutMeState({
    this.summary = '',
    this.videoPath,
    this.existingVideoUrl,
    this.status = FormStatus.initial,
  });

  static const _sentinel = Object();


  AboutMeState copyWith({
    String? summary,
    Object? videoPath = _sentinel,
    Object? existingVideoUrl = _sentinel,
    FormStatus? status,
  }) {
    return AboutMeState(
      summary: summary ?? this.summary,
     
      videoPath: videoPath == _sentinel
          ? this.videoPath
          : (videoPath as String?),

      existingVideoUrl: existingVideoUrl == _sentinel
          ? this.existingVideoUrl
          : (existingVideoUrl as String?),
          
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [summary, videoPath, existingVideoUrl, status];
}
