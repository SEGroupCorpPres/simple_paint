import 'package:simple_paint/core/core.dart';

AppBarTheme appBarTheme(BuildContext context) => AppBarTheme(
  titleTextStyle: GoogleFonts.roboto(
    fontSize: AppSizes.fontSize17.sp,
    color: AppColors.mainTextColor,
    fontWeight: FontWeight.w500,
    height: AppSizes.fontSize17.sp,
    letterSpacing: 0,
  ),
  elevation: 2,
  backgroundColor: Color(0x03C4C4C4),
);

ThemeData darkTheme(BuildContext context) => ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.mainColor,
  appBarTheme: appBarTheme(context),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.pressStart2p(
      fontSize: AppSizes.fontSize20.sp,
      color: AppColors.mainTextColor,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    titleMedium: GoogleFonts.pressStart2p(
      fontSize: AppSizes.fontSize17.sp,
      color: AppColors.mainTextColor,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
  ),
  scaffoldBackgroundColor: AppColors.mainColor,
  inputDecorationTheme: InputDecorationTheme(
    constraints: BoxConstraints(minHeight: 60.h),
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: AppColors.secondaryColor, width: .5.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: CupertinoColors.systemGreen, width: 1.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: CupertinoColors.systemBlue, width: 1.w),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: CupertinoColors.destructiveRed, width: 1.w),
    ),
    helperStyle: GoogleFonts.roboto(
      fontSize: AppSizes.fontSize14.sp,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 24.sp,
    ),
    // labelStyle: TextStyle(
    //   fontFamily: 'VelaSans',
    //   fontSize: 16.sp,
    //   color: AppColors.secondaryColor,
    //   fontWeight: FontWeight.w500,
    // ),
    // errorStyle: TextStyle(
    //   fontFamily: 'VelaSans',
    //   height: 1.3,
    //   fontSize: 16.sp,
    //   overflow: TextOverflow.visible,
    //   color: CupertinoColors.destructiveRed,
    //   fontWeight: FontWeight.w500,
    // ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      enableFeedback: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius.r),
      ),
      backgroundColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateColor.transparent,
      surfaceTintColor: Colors.transparent,
      fixedSize: Size(double.infinity, 48.h),
      textStyle: GoogleFonts.roboto(
        fontSize: AppSizes.fontSize17.sp,
        color: AppColors.mainTextColor,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
    ),
  ),
);
