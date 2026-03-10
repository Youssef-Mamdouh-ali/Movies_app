import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/home/search_view/widgets/empty_state.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                child: CustomTextFormFieldWidget(
                  text: AppString.search,
                  customPrefixWidget: Icon(Icons.search),
                ),
              ),
              CustomEmptyStateWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
