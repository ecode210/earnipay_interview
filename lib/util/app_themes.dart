import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData lightTheme({required BuildContext context}) => ThemeData(
        useMaterial3: true,
        unselectedWidgetColor: const Color(0xFF535F70),
        dividerColor: const Color(0xFFFFFFFF),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF006C50),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFF85F8CC),
          onPrimaryContainer: Color(0xFF002116),
          secondary: Color(0xFF4C6359),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFCEE9DB),
          onSecondaryContainer: Color(0xFF092017),
          tertiary: Color(0xFF3F6374),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFC2E8FD),
          onTertiaryContainer: Color(0xFF001F2A),
          error: Color(0xFFBA1A1A),
          errorContainer: Color(0xFFFFDAD6),
          onError: Color(0xFFFFFFFF),
          onErrorContainer: Color(0xFF410002),
          background: Color(0xFFFBFDF9),
          onBackground: Color(0xFF191C1A),
          surface: Color(0xFFFBFDF9),
          onSurface: Color(0xFF191C1A),
          surfaceVariant: Color(0xFFDBE5DE),
          onSurfaceVariant: Color(0xFF404944),
          outline: Color(0xFF707974),
          onInverseSurface: Color(0xFFEFF1EE),
          inverseSurface: Color(0xFF2E312F),
          inversePrimary: Color(0xFF67DBB1),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF006C50),
          outlineVariant: Color(0xFFBFC9C2),
          scrim: Color(0xFF000000),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          TextTheme(
            headlineLarge: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            headlineMedium: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  static ThemeData darkTheme({required BuildContext context}) => ThemeData(
        useMaterial3: true,
        unselectedWidgetColor: Colors.grey.shade800,
        dividerColor: const Color(0xFF181818),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF67DBB1),
          onPrimary: Color(0xFF003828),
          primaryContainer: Color(0xFF00513B),
          onPrimaryContainer: Color(0xFF85F8CC),
          secondary: Color(0xFFB3CCBF),
          onSecondary: Color(0xFF1E352C),
          secondaryContainer: Color(0xFF354B41),
          onSecondaryContainer: Color(0xFFCEE9DB),
          tertiary: Color(0xFFA6CCE0),
          onTertiary: Color(0xFF093544),
          tertiaryContainer: Color(0xFF264B5C),
          onTertiaryContainer: Color(0xFFC2E8FD),
          error: Color(0xFFFFB4AB),
          errorContainer: Color(0xFF93000A),
          onError: Color(0xFF690005),
          onErrorContainer: Color(0xFFFFDAD6),
          background: Color(0xFF191C1A),
          onBackground: Color(0xFFE1E3DF),
          surface: Color(0xFF191C1A),
          onSurface: Color(0xFFE1E3DF),
          surfaceVariant: Color(0xFF404944),
          onSurfaceVariant: Color(0xFFBFC9C2),
          outline: Color(0xFF89938D),
          onInverseSurface: Color(0xFF191C1A),
          inverseSurface: Color(0xFFE1E3DF),
          inversePrimary: Color(0xFF006C50),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF67DBB1),
          outlineVariant: Color(0xFF404944),
          scrim: Color(0xFF000000),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          TextTheme(
            headlineLarge: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            headlineMedium: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
