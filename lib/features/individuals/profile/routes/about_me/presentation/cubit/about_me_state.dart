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

  // 1. Create a private constant to act as a flag
  static const _sentinel = Object();

  // 2. Change the nullable parameters to default to the _sentinel
  //    and change their type to Object? so they can accept the sentinel.
  AboutMeState copyWith({
    String? summary,
    Object? videoPath = _sentinel,
    Object? existingVideoUrl = _sentinel,
    FormStatus? status,
  }) {
    return AboutMeState(
      summary: summary ?? this.summary,
      
      // 3. Logic: If value is sentinel, keep old. 
      //    If value is NOT sentinel (even if it is null), use the new value.
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
