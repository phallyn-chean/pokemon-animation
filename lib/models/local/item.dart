import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 4)
class ItemHiveModel extends HiveObject {
  static const String boxKey = 'item';

  @HiveField(0)
  late String name;

  @HiveField(1)
  late String category;

  @HiveField(2)
  late String imageurl;

  @HiveField(3)
  late String effect;
}
