import 'package:simple_paint/core/core.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    required this.keyboardType,
    this.validator, required this.focusNode,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode focusNode;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.defaultFormInputHeight.h,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.defaultFormInputContentPadding.w,
        vertical: AppSizes.defaultFormInputContentPadding.h - 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryTextColor,
        borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
        border: Border.all(color: Colors.white24, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.blurColor,
            spreadRadius: 0,
            blurRadius: 40,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText.tr(), style: Theme.of(context).textTheme.labelSmall),
          TextFormField(
            focusNode: focusNode,
            // onChanged: (value){
            //   print(value);
            // },
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText!,
            style: Theme.of(context).textTheme.labelSmall,
            validator: validator,
            decoration: InputDecoration(hintText: hintText.tr()),
          ),
        ],
      ),
    );
  }
}
