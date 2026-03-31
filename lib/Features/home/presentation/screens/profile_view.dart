import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/authentication/presentation/manager/auth_bloc.dart';
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
    _loadData();
  }

  void _loadData() {
    context.read<HomeBloc>().add(const FetchProfileData());
    context.read<AuthBloc>().add(const AuthenticationEventGetUserData());
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessSignOutState) {
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                String userName = "Loading...";
                String userImageUrl = AppAssets.avatar2;

                if (authState is SuccessGetUserDataState) {
                  userName = authState.name;
                  userImageUrl = authState.photoUrl.isNotEmpty
                      ? authState.photoUrl
                      : AppAssets.avatar2;
                }

                return BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) {
                    final watchListCount = homeState.watchListState is WatchListSuccess
                        ? (homeState.watchListState as WatchListSuccess).movies.length
                        : 0;
                    final historyCount = homeState.historyState is HistorySuccess
                        ? (homeState.historyState as HistorySuccess).movies.length
                        : 0;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PagesRoutesName.updateProfileScreen,
                            ).then((value) {
                              if (mounted) _loadData();
                            });
                          },
                          child: CustomHeaderContainerProfileWidget(
                            nameText: userName,
                            imageUrl: userImageUrl,
                            wishListCount: watchListCount,
                            historyCount: historyCount,
                          ),
                        ),

                        Container(
                          height: 60,
                          decoration: BoxDecoration(color: AppColors.greyColor),
                          child: CustomTabBarWidget(
                            onTap: (index) => setState(() => selectedIndex = index),
                            tabTitles: [appLocalizations.watchList, appLocalizations.history],
                            tabIcons: [AppAssets.watchListIcon, AppAssets.folderIcon],
                          ),
                        ),

                        Expanded(
                          child: IndexedStack(
                            index: selectedIndex,
                            children: const [
                              CustomWatchListBodyWidget(),
                              CustomHistoryListBodyWidget(),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}