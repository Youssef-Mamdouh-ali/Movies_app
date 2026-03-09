import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';

class RegisterDataModel {
  String id;
  String imagePath;

  RegisterDataModel({required this.id, required this.imagePath});

  static List<RegisterDataModel> registerList = [
    RegisterDataModel(
      id: "bearded_gamer",
      imagePath: AppAssets.avatar1,
    ),
    RegisterDataModel(
      id: "cool_gamer",
      imagePath: AppAssets.avatar2,
    ),
    RegisterDataModel(
      id: "blonde_female",
      imagePath: AppAssets.avatar3,
    ),
    RegisterDataModel(
      id: "gentleman",
      imagePath: AppAssets.avatar4,
    ),
    RegisterDataModel(
      id: "red_head_female",
      imagePath: AppAssets.avatar5,
    ),
    RegisterDataModel(
      id: "cat_ears_female",
      imagePath: AppAssets.avatar6,
    ),
    RegisterDataModel(
      id: "bearded_man",
      imagePath: AppAssets.avatar7,
    ),
    RegisterDataModel(
      id: "hoodie_boy",
      imagePath: AppAssets.avatar8,
    ),
    RegisterDataModel(
      id: "gamer_girl",
      imagePath: AppAssets.avatar9,
    ),
  ];
}
