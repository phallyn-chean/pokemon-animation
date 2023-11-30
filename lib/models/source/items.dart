import 'package:json_annotation/json_annotation.dart';

part 'items.g.dart';

@JsonSerializable()
class GithubItemModel {
  @JsonKey(disallowNullValue: true)
  late String name;

  @JsonKey(defaultValue: '')
  late String category;

  @JsonKey(disallowNullValue: true)
  late String imageurl;

  @JsonKey(disallowNullValue: true)
  late String effect;

  GithubItemModel(
    this.name,
    this.category,
    this.imageurl,
    this.effect,
  );

  factory GithubItemModel.fromJson(Map<String, dynamic> json) {
    return _$GithubItemModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GithubItemModelToJson(this);
  }
}
