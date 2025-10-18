import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emilController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    emilController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emilController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedInState) {
            Fluttertoast.showToast(
                msg: AppConstants.authPageLoginSuccess.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: CupertinoColors.systemGreen,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                context.push(RouterNames.home);
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
                    AuthBodyTitle(title: AppConstants.authPageLogin),
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
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignInEvent(
                            email: emilController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    },
                    title: AppConstants.authPageSignIn,
                    size: size,
                  ),
                  MainBtn(
                    onPressed: () {
                      context.push(RouterNames.register);
                    },
                    title: AppConstants.authPageSignUp,
                    size: size,
                    color: Colors.white,
                    titleColor: AppColors.secondaryTextColor,
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
