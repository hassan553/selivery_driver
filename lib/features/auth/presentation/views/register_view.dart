import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/show_awesomeDialog.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../home/views/main_view.dart';
import '../../date/driver_auth_repo.dart';
import '../widgets/google_sigin_widget.dart';
import 'car_info_view.dart';
import '../../verify_email/views/otp_view.dart';
import '../../../../../core/functions/global_function.dart';
import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/build_rich_text.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/custom_text_filed.dart';
import '../../../../../core/widgets/snack_bar_widget.dart';
import '../../cubit/register/driver_register_cubit.dart';

class DriverRegisterView extends StatefulWidget {
  const DriverRegisterView({super.key});

  @override
  State<DriverRegisterView> createState() => _DriverRegisterViewState();
}

class _DriverRegisterViewState extends State<DriverRegisterView> {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();
  var nameFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  void changeIcon() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    nameFocus.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DriverRegisterCubit(DriverAuthRepo()),
        child: InkWell(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenSize(context).height * .06),
                      Align(
                          alignment: Alignment.center,
                          child: CustomAssetsImage(
                              path: 'assets/Young man ordering taxi.png')),
                      const Center(
                          child: CustomRichText(
                        color: AppColors.primaryColor,
                        imagePath: 'assets/image.png',
                      )),
                      SizedBox(height: screenSize(context).height * .05),
                      CustomTextFieldWidget(
                        controller: name,
                        focusNode: nameFocus,
                        submit: (p0) =>
                            FocusScope.of(context).requestFocus(emailFocus),
                        hintText: 'الاسم',
                        valid: (String? value) {
                          if (value == null) {
                            return 'قيمة فارغة غير صالحة';
                          }
                        },
                      ),
                      SizedBox(height: screenSize(context).height * .03),
                      CustomTextFieldWidget(
                        controller: email,
                        hintText: 'البريد الاكتروني',
                        focusNode: emailFocus,
                        submit: (p0) =>
                            FocusScope.of(context).requestFocus(passwordFocus),
                        valid: (String? value) {
                          if (value == null) {
                            return 'قيمة فارغة غير صالحة';
                          }
                          if (!value.contains('@')) {
                            return 'الرجاء إدخال بريد إلكتروني صحيح';
                          }
                        },
                      ),
                      SizedBox(height: screenSize(context).height * .03),
                      CustomTextFieldWidget(
                        controller: password,
                        obscure: isObscure,
                        suffixIcon: InkWell(
                          onTap: () => changeIcon(),
                          child: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'كلمه السر',
                        focusNode: passwordFocus,
                        valid: (String? value) {
                          if (value == null) {
                            return 'قيمه فارغه';
                          }
                          if (value.length < 6) {
                            return 'كلمة مرور قصيرة . على الأقل 6 خانات';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize(context).height * .05),
                      BlocConsumer<DriverRegisterCubit, DriverRegisterState>(
                          listener: (context, state) {
                        if (state is DriverRegisterSuccess) {
                          showSnackBarWidget(
                              context: context,
                              message: 'تم انشاء الحساب بنجاح',
                              requestStates: RequestStates.success);
                          navigatorOff(
                              context,
                              VerifyDriverEmailOTPView(
                                email: email.text,
                                screen: const CompleteCarInfoView(),
                              ));
                        } else if (state is DriverRegisterError) {
                          showErrorAwesomeDialog(
                              context, 'تنبيه', state.message);
                        }
                      }, builder: (context, state) {
                        if (state is DriverRegisterLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor),
                          );
                        }
                        return CustomButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<DriverRegisterCubit>(context)
                                    .register(
                                        name.text.trim(),
                                        email.text.trim(),
                                        password.text.trim());
                              }
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            color: AppColors.primaryColor,
                            title: 'ان شاء حساب');
                      }),
                      SizedBox(height: screenSize(context).height * .03),
                      BlocConsumer<DriverRegisterCubit, DriverRegisterState>(
                        listener: (context, state) {
                          if (state is DriverGoogleRegisterSuccess) {
                            showSnackBarWidget(
                                context: context,
                                message: 'تم تسجيل الدخوال بنجاح',
                                requestStates: RequestStates.success);
                            navigateOff(MainView());
                          } else if (state is DriverGoogleRegisterError) {
                            print(state.message);
                            showErrorAwesomeDialog(
                                context, 'تنبيه', state.message);
                          }
                        },
                        builder: (context, state) {
                          return state is DriverGoogleRegisterLoading
                              ? const CustomLoadingWidget()
                              : GoogleSignWidget(onTap: () {
                                  BlocProvider.of<DriverRegisterCubit>(context)
                                      .registerWithGoogle();
                                });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
