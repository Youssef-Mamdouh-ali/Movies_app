import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_up_request.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_bloc.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_event.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_state.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/extension/padding_extension.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_app_bar_widget.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';
import '../../../../core/widgets/custom_language_switch_widget.dart';
import '../manager/auth_bloc.dart';
import '../widgets/custom_carousel_slider_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // 1. تعريف الـ Controllers والـ FormKey
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  int selectedIndex = 0;
  bool isActivePassword = true;
  bool isActiveConfirmPassword = true;
  bool isArabic = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessSignUpState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account Created Successfully!")),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            PagesRoutesName.layoutView,
                (route) => false,
          );
        } else if (state is ErrorSignUpState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBarWidget(
            customTitleWidget: Text(
              appLocalizations.register,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            customLeadingWidget: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_outlined, color: AppColors.primaryColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar Carousel
                  CustomCarouselSliderWidget(
                    items: RegisterDataModel.registerList.map((avatar) {
                      return Container(
                        width: 125,
                        height: 160,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.asset(
                            avatar.imagePath,
                            fit: BoxFit.cover,
                            width: 125,
                            height: 160,
                          ),
                        ),
                      );
                    }).toList(),
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(appLocalizations.avatar, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 12),

                  // Name Field
                  CustomTextFormFieldWidget(
                    controller: _nameController,
                    validator: (value) => value!.isEmpty ? "Enter your name" : null,
                    text: appLocalizations.name,
                    customPrefixWidget: SvgPicture.asset(
                      AppAssets.nameIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  CustomTextFormFieldWidget(
                    controller: _emailController,
                    validator: (value) => value!.isEmpty ? "Enter your email" : null,
                    text: appLocalizations.email,
                    customPrefixWidget: SvgPicture.asset(
                      AppAssets.emailIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Password Field
                  CustomTextFormFieldWidget(
                    controller: _passwordController,
                    isPassword: isActivePassword,
                    validator: (value) => value!.length < 6 ? "Password too short" : null,
                    text: appLocalizations.password,
                    customPrefixWidget: SvgPicture.asset(
                      AppAssets.passwordIcon,
                      width: 24,
                      height: 24,
                    ),
                    customSuffixWidget: InkWell(
                      onTap: () => setState(() => isActivePassword = !isActivePassword),
                      child: Icon(
                        isActivePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Confirm Password Field
                  CustomTextFormFieldWidget(
                    controller: _confirmPasswordController,
                    isPassword: isActiveConfirmPassword,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    text: appLocalizations.confirmPassword,
                    customPrefixWidget: SvgPicture.asset(
                      AppAssets.passwordIcon,
                      width: 24,
                      height: 24,
                    ),
                    customSuffixWidget: InkWell(
                      onTap: () => setState(() => isActiveConfirmPassword = !isActiveConfirmPassword),
                      child: Icon(
                        isActiveConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Phone Number Field
                  CustomTextFormFieldWidget(
                    controller: _phoneController,
                    text: appLocalizations.phoneNumber,
                    customPrefixWidget: SvgPicture.asset(
                      AppAssets.phoneIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Create Account Button
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButtonWidget(
                          onPressed: state is LoadingSignUpState
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              final request = SignUpRequest(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                phone: _phoneController.text,
                                avatar: RegisterDataModel.registerList[selectedIndex].imagePath,
                              );
                              context.read<AuthBloc>().add(
                                AuthenticationEventSignUp(signUpRequest: request),
                              );
                            }
                          },
                          customChildWidget: state is LoadingSignUpState
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            appLocalizations.headerCreateAccount,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppColors.greyColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Already have an account? Login
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: appLocalizations.alreadyHaveAccount,
                            style: theme.textTheme.bodyMedium,
                          ),
                          WidgetSpan(
                            child: Bounceable(
                              onTap: () {
                                Navigator.pushNamed(context, PagesRoutesName.loginView);
                              },
                              child: Text(
                                "  ${appLocalizations.login}",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Language Switch
                  BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, langState) {
                      bool isCurrentlyArabic = langState.locale.languageCode == 'ar';
                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLanguageSwitchWidget(
                              isArabic: isCurrentlyArabic,
                              onTapLeft: () {
                                if (isCurrentlyArabic) {
                                  context.read<LanguageBloc>().add(ChangeLanguageEvent('en'));
                                }
                              },
                              onTapRight: () {
                                if (!isCurrentlyArabic) {
                                  context.read<LanguageBloc>().add(ChangeLanguageEvent('ar'));
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ).setHorizontalAndVerticalPadding(
                context,
                18,
                8,
                enableMediaQuery: false,
              ),
            ),
          ),
        );
      },
    );
  }
}

class RegisterDataModel {
  String id;
  String imagePath;

  RegisterDataModel({required this.id, required this.imagePath});

  static List<RegisterDataModel> registerList = [
    RegisterDataModel(id: "avatar1", imagePath: AppAssets.avatar1),
    RegisterDataModel(id: "avatar2", imagePath: AppAssets.avatar2),
    RegisterDataModel(id: "avatar3", imagePath: AppAssets.avatar3),
    RegisterDataModel(id: "avatar4", imagePath: AppAssets.avatar4),
    RegisterDataModel(id: "avatar5", imagePath: AppAssets.avatar5),
    RegisterDataModel(id: "avatar6", imagePath: AppAssets.avatar6),
    RegisterDataModel(id: "avatar7", imagePath: AppAssets.avatar7),
    RegisterDataModel(id: "avatar8", imagePath: AppAssets.avatar8),
    RegisterDataModel(id: "avatar9", imagePath: AppAssets.avatar9),
  ];
}