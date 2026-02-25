import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';

class RegisterDataModel {
  String id;
  String imagePath;

  RegisterDataModel({required this.id, required this.imagePath});

  static List<RegisterDataModel> registerList = [
    RegisterDataModel(
      id: "bearded_gamer",
      imagePath: AppAssets.beardedGamerProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "cool_gamer",
      imagePath: AppAssets.coolGamerProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "blonde_female",
      imagePath: AppAssets.blondeFemaleProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "gentleman",
      imagePath: AppAssets.gentlemanProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "red_head_female",
      imagePath: AppAssets.redHeadFemaleProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "cat_ears_female",
      imagePath: AppAssets.catEarsFemaleProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "bearded_man",
      imagePath: AppAssets.beardedManProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "hoodie_boy",
      imagePath: AppAssets.hoodieBoyProfileBackgroundImg,
    ),
    RegisterDataModel(
      id: "gamer_girl",
      imagePath: AppAssets.gamerGirlProfileBackgroundImg,
    ),
  ];
}
