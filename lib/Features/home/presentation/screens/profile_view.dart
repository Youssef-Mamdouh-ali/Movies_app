import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/authentication/presentation/manager/auth_bloc.dart'; // ✅ استيراد AuthBloc
import 'package:movies_app_project/Features/home/presentation/bloc/home_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_event.dart';
import 'package:movies_app_project/Features/home/presentation/bloc/home_state.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_header_container_profile_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_history_list_body_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_tab_bar_widget.dart';
import 'package:movies_app_project/Features/home/presentation/widgets/custom_watch_list_body_widget.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // ✅ 1. جلب بيانات الأفلام (Counts) من Hive
    context.read<HomeBloc>().add(const FetchProfileData());
    // ✅ 2. جلب بيانات المستخدم (Name & Photo) من Firebase
    context.read<AuthBloc>().add(const AuthenticationEventGetUserData());
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    // 🛡️ أولاً: مراقبة حالة الخروج (Navigation)
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessSignOutState) {
          // ✅ عند نجاح الخروج، نمسح كل الصفحات ونرجع للـ Login
          Navigator.pushNamedAndRemoveUntil(
            context,
            PagesRoutesName.loginView,
                (route) => false,
          );
        } else if (state is ErrorSignOutState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          // 🛡️ ثانياً: بناء واجهة المستخدم بناءً على بيانات الحساب (Auth)
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              String userName = appLocalizations.nameText;
              String? userImageUrl;

              if (authState is SuccessGetUserDataState) {
                userName = authState.name;
                userImageUrl = authState.photoUrl;
              }

              // 🛡️ ثالثاً: بناء واجهة المستخدم بناءً على بيانات الأفلام (Home)
              return BlocBuilder<HomeBloc, HomeState>(
                builder: (context, homeState) {
                  // حساب الأرقام من حالات النجاح
                  final watchListCount = homeState.watchListState is WatchListSuccess
                      ? (homeState.watchListState as WatchListSuccess).movies.length
                      : 0;
                  final historyCount = homeState.historyState is HistorySuccess
                      ? (homeState.historyState as HistorySuccess).movies.length
                      : 0;

                  return DefaultTabController(
                    length: 2,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // الـ Header بياخد البيانات من الـ AuthState والـ HomeState سوا
                          CustomHeaderContainerProfileWidget(
                            nameText: userName,
                            imageUrl: userImageUrl ?? "", // الرابط الحقيقي
                            wishListCount: watchListCount,
                            historyCount: historyCount,
                          ),

                          // الـ Tab Bar للتبديل بين القوائم
                          Container(
                            height: 60,
                            decoration: BoxDecoration(color: AppColors.greyColor),
                            child: CustomTabBarWidget(
                              onTap: (index) => setState(() => selectedIndex = index),
                              tabTitles: [appLocalizations.watchList, appLocalizations.history],
                              tabIcons: [AppAssets.watchListIcon, AppAssets.folderIcon],
                            ),
                          ),

                          // عرض المحتوى بناءً على التاب المختارة
                          selectedIndex == 0
                              ? const CustomWatchListBodyWidget()
                              : const CustomHistoryListBodyWidget(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}