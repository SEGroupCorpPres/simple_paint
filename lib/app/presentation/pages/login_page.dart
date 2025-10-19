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
  late FocusNode passwordFocusNode;
  late FocusNode emailFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    emilController = TextEditingController();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emilController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedInState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,

              title: const Text('Success'),
              description: const Text('Sign in successfully!'),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
            );
            context.read<AuthBloc>().add(CacheFirstTimerEvent());
            context.go(RouterNames.home);
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
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  spacing: AppSizes.defaultFormGap,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthBodyTitle(title: AppConstants.authPageLogin),
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
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: size.width,
              height: (emailFocusNode.hasFocus || passwordFocusNode.hasFocus) ? 50.h : 0,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h),
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
            ),
          ],
        ),
      ),
    );
  }
}
