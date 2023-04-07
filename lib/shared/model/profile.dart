import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

part 'profile.g.dart';

Profile profileFromJson(Map<String, dynamic> str) => Profile.fromJson(str);


Map<String, dynamic> toJson(Profile model) {
  return <String, dynamic>{
    '_id': model.id,
    'email': model.email,
    'name': model.name,
    'role': model.role,
    'language': model.language,
    'phone': model.phone,
    'desc': model.desc,
  };
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    @JsonKey(name: '_id') String? id,
    String? email,
    String? name,
    String? role,
    String? language,
    String? phone,
    String? desc,
  }) = _Profile;

  const Profile._();

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
