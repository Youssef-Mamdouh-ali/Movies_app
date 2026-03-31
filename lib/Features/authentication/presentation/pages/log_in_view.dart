import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_in_request.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_bloc.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_event.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_state.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';
import 'package:movies_app_project/core/utils/app_assets/app_assets.dart';
import 'package:movies_app_project/core/utils/app_strings/app_string.dart';
import 'package:movies_app_project/core/utils/app_validator/app_validator.dart';
import 'package:movies_app_project/core/utils/extension/padding_extension.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';
import 'package:movies_app_project/core/widgets/custom_elevated_button_widget.dart';
import 'package:movies_app_project/core/widgets/custom_text_form_field_widget.dart';
import '../../../../core/widgets/custom_language_switch_widget.dart';
import '../manager/auth_bloc.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  bool isActive = true;
  bool isArabic = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessSignInState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            PagesRoutesName.layoutView,
            (route) => false,
          );
        } else if (state is ErrorSignInState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid email or password"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.headerLogo,
                        width: 120,
                        height: 118,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 69),

                      /// email
                      CustomTextFormFieldWidget(
                        validator: AppValidators.validateEmail,
                        controller: _emailController,
                        text: appLocalizations.email,
                        customPrefixWidget: SvgPicture.asset(
                          AppAssets.emailIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(height: 22.5),

                      /// password
                      CustomTextFormFieldWidget(
                        validator: AppValidators.validatePassword,
                        controller: _passwordController,
                        text: appLocalizations.password,
                        isPassword: isActive,
                        customPrefixWidget: SvgPicture.asset(
                          AppAssets.passwordIcon,
                          width: 24,
                          height: 24,
                        ),
                        customSuffixWidget: InkWell(
                          onTap: () {
                            setState(() {
                              isActive = !isActive;
                            });
                          },
                          child: isActive
                              ? SvgPicture.asset(
                                  AppAssets.eyeIcon,
                                  width: 24,
                                  height: 24,
                                )
                              : const Icon(
                                  Icons.remove_red_eye_sharp,
                                  color: AppColors.whiteColor,
                                ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PagesRoutesName.forgetPasswordView,
                              );
                            },
                            child: Text(
                              appLocalizations.forgetPassword,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryColor,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 33),

                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButtonWidget(
                              onPressed: state is LoadingSignInState
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        var data = SignInRequest(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                        context.read<AuthBloc>().add(
                                          AuthenticationEventSignIn(
                                            signInRequest: data,
                                          ),
                                        );
                                      }
                                    },
                              customChildWidget: state is LoadingSignInState
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.whiteColor,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      appLocalizations.login,
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            color: AppColors.greyColor,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 23),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: appLocalizations.doNotHaveAccount,
                                style: theme.textTheme.bodyMedium,
                              ),
                              WidgetSpan(
                                child: Bounceable(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      PagesRoutesName.registerView,
                                    );
                                  },
                                  child: Text(
                                    appLocalizations.register,
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
                      const SizedBox(height: 23),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(indent: 99.5, endIndent: 15),
                          ),
                          Text(
                            appLocalizations.or,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const Expanded(
                            child: Divider(indent: 15, endIndent: 99.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButtonWidget(
                              onPressed: () {},
                              customChildWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.googleIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    appLocalizations.loginWithGoogle,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 33.5),
                      BlocBuilder<LanguageBloc, LanguageState>(
                        builder: (context, langState) {
                          bool isCurrentlyArabic =
                              langState.locale.languageCode == 'ar';
                          return Directionality(
                              textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLanguageSwitchWidget(
                                  isArabic: isCurrentlyArabic,
                                  onTapLeft: () {
                                    if (isCurrentlyArabic) {
                                      context.read<LanguageBloc>().add(
                                        ChangeLanguageEvent('en'),
                                      );
                                    }
                                  },
                                  onTapRight: () {
                                    if (!isCurrentlyArabic) {
                                      context.read<LanguageBloc>().add(
                                        ChangeLanguageEvent('ar'),
                                      );
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
                    16,
                    48,
                    enableMediaQuery: false,
                  ),
            ),
          ),
        );
      },
    );
  }
}
