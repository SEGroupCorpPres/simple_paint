import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emilController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  late FocusNode passwordFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode nameFocusNode;
  late FocusNode confirmPasswordFocusNode;
  ValueListenable<bool> isIgnoring = ValueNotifier(true);
  late Color titleColor = AppColors.secondaryTextColor;
  late Color? bgColor = AppColors.secondaryColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    for (final node in [
      nameFocusNode,
      emailFocusNode,
      passwordFocusNode,
      confirmPasswordFocusNode,
    ]) {
      node.addListener(() {
        if (node.hasFocus) {
          _scrollToFocusedField(node);
        }
      });
    }
    // for (var controller in [
    //   nameController,
    //   emilController,
    //   passwordController,
    //   confirmPasswordController,
    // ]) {
    //   controller.addListener(listener);
    // }
  }

  void _scrollToFocusedField(FocusNode node) {
    // 🔹 Keyboard paydo bo‘lganda fokuslangan maydonni ko‘rsatish uchun animatsion scroll
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.offset + 150,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // void listener() {
  //   setState(() {
  //     log('listener');
  //     isIgnoring = nameController.text.isEmpty ? ValueNotifier(true) : ValueNotifier(false);
  //     titleColor = nameController.text.isEmpty ? AppColors.secondaryColor : AppColors.mainTextColor;
  //     bgColor = nameController.text.isEmpty ? AppColors.secondaryColor : null;
  //   });
  // }

  @override
  void dispose() {
    scrollController.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    nameController.dispose();
    emilController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedUpState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,
              title: const Text('Success'),
              description: const Text('Auth Signed Up Successfully'),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                context.push(RouterNames.login);
              }
            });
          }
          if (state is AuthLoadingState) {
            showDialog(
              context: context,
              builder: (context) => const SimpleDialog(
                children: [Center(child: CircularProgressIndicator.adaptive())],
              ),
            );
          }
          if (state is AuthErrorState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,
              title: const Text('Error'),
              description: Text(state.message),
              type: ToastificationType.error,
              autoCloseDuration: const Duration(seconds: 3),
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                context.pop();
                context.pop();
              }
            });
          }
        },
        child: ScaffoldBuilderWidget(
          isHome: false,
          bodyMainAxisAlignment: MainAxisAlignment.center,
          appBarChildren: [],
          bodyChildren: [
            Spacer(),
            SizedBox(
              height: (AppSizes.defaultFormInputHeight.h + AppSizes.defaultFormGap.h) * 4 + 50.h,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.defaultAuthScreenHorizontalPadding.w,
                      ),
                      child: Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: _formKey,
                        child: Column(
                          spacing: AppSizes.defaultFormGap,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AuthBodyTitle(title: AppConstants.authPageRegistration),
                            AuthTextField(
                              focusNode: nameFocusNode,
                              controller: nameController,
                              labelText: AppConstants.authPageFormNameLabel,
                              hintText: AppConstants.authPageFormNameHelperText,
                              keyboardType: TextInputType.text,
                            ),
                            AuthTextField(
                              focusNode: emailFocusNode,
                              controller: emilController,
                              labelText: AppConstants.authPageFormEmailLabel,
                              hintText: AppConstants.authPageFormEmailHelperText,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            AuthTextField(
                              focusNode: passwordFocusNode,
                              controller: passwordController,
                              labelText: AppConstants.authPageFormPasswordLabel,
                              hintText: AppConstants.authPageFormPasswordHelperText,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6 || value.length > 16) {
                                  return 'Password must be between 8 and 16 characters';
                                }
                                return null;
                              },
                            ),
                            AuthTextField(
                              focusNode: confirmPasswordFocusNode,
                              controller: confirmPasswordController,
                              labelText: AppConstants.authPageFormConfirmPasswordLabel,
                              hintText: AppConstants.authPageFormConfirmPasswordHelperText,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Column(
                  spacing: AppSizes.defaultFormGap,
                  children: [
                    MainBtn(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            passwordController.text == confirmPasswordController.text) {
                          context.read<AuthBloc>().add(
                            AuthSignUpEvent(
                              name: nameController.text,
                              email: emilController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      isIgnoring: false,
                      title: AppConstants.authPageRegistration,
                      size: size,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
