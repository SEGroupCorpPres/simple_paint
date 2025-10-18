import 'package:simple_paint/core/core.dart';

class AppColors {
  static const Color mainColor = Color(0xFF280F2C);
  static const Color secondaryColor = Color(0xFF87858F);
  static const Color blurColor = Color(0x33E3E3E3);
  static const Color mainTextColor = Color(0xFFEEEEEE);
  static const Color secondaryTextColor = Color(0xFF131313);
  static const Color helperTextColor = Color(0xFF87858F);
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF8924E7), Color(0xFF6A46F9)],
  );
}
