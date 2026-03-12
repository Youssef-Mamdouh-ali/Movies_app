import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/Features/home/presentation/manger/layout_bloc.dart';
import 'package:movies_app_project/core/services/service_locator.dart';

import '../widgets/BrowseViewContent.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LayoutBloc>()..add(GetMoviesEvent("Drama")),
      child: const BrowseViewContent(),
    );
  }
}