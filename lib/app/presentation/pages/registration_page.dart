import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emilController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  ValueListenable<bool> isIgnoring = ValueNotifier(true);
  late Color titleColor = AppColors.secondaryTextColor;
  late Color? bgColor = AppColors.secondaryColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var controller in [
      nameController,
      emilController,
      passwordController,
      confirmPasswordController,
    ]) {
      controller.addListener(listener);
    }
  }

  void listener() {
    setState(() {
      log('listener');
      isIgnoring = nameController.text.isEmpty ? ValueNotifier(true) : ValueNotifier(false);
      titleColor = nameController.text.isEmpty ? AppColors.secondaryColor : AppColors.mainTextColor;
      bgColor = nameController.text.isEmpty ? AppColors.secondaryColor : null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emilController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedUpState) {
            Fluttertoast.showToast(
                msg: AppConstants.authPageRegisterSuccess.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: CupertinoColors.systemGreen,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                context.push(RouterNames.login);
              }
            });
          }
          if (state is AuthLoadingState) {
            LoadingView();
          }
          if (state is AuthErrorState) {
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: CupertinoColors.destructiveRed,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        child: ScaffoldBuilderWidget(
          isHome: false,
          bodyMainAxisAlignment: MainAxisAlignment.spaceBetween,
          appBarChildren: [],
          bodyChildren: [
            SizedBox(height: 100.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.defaultAuthScreenHorizontalPadding.w,
              ),
              child: Form(
                key: _formKey,

                child: Column(
                  spacing: AppSizes.defaultFormGap,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthBodyTitle(title: AppConstants.authPageRegistration),
                    AuthTextField(
                      controller: nameController,
                      labelText: AppConstants.authPageFormNameLabel,
                      hintText: AppConstants.authPageFormNameHelperText,
                      keyboardType: TextInputType.text,
                    ),
                    AuthTextField(
                      controller: emilController,
                      labelText: AppConstants.authPageFormEmailLabel,
                      hintText: AppConstants.authPageFormEmailHelperText,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    AuthTextField(
                      controller: passwordController,
                      labelText: AppConstants.authPageFormPasswordLabel,
                      hintText: AppConstants.authPageFormPasswordHelperText,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    AuthTextField(
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
            SafeArea(
              child: Column(
                spacing: AppSizes.defaultFormGap,
                children: [
                  MainBtn(
                    onPressed: () {
                      print('register');
                      print(_formKey.currentState!.validate() &&
                          passwordController == confirmPasswordController);
                      if (_formKey.currentState!.validate() &&
                          passwordController.text == confirmPasswordController.text) {
                        print('register validate');
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
          ],
        ),
      ),
    );
  }
}
