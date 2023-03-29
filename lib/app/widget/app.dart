import 'package:nvc_cinemas/app/widget/app_init.dart';
import 'package:nvc_cinemas/feature/auth/widget/sign_in.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/gen/fonts.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/widget/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:one_context/one_context.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // final profile = ref.watch(profileProvider);
    final callRoutes = <String, PageContentBuilder>{
      '/init': ([Object? arguments]) => const AppInit(),
      '/home-page': ([Object? arguments]) => const HomePage(),
      '/sign-in': ([Object? arguments]) => const SignIn(),
    };

    Route<dynamic>? onGenerateRoute(RouteSettings settings) {
      final name = settings.name as String;
      final PageContentBuilder? pageContentBuilder = callRoutes[name];
      if (pageContentBuilder != null) {
        if (settings.arguments != null) {
          final Route route = MaterialPageRoute<Widget>(
            builder: (context) => pageContentBuilder(settings.arguments),
          );

          return route;
        } else {
          final route = MaterialPageRoute<Widget>(
            builder: (context) => pageContentBuilder(),
          );

          return route;
        }
      }

      return null;
    }

    return MaterialApp(
      builder: OneContext().builder,
      navigatorKey: OneContext().navigator.key,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: ColorName.primary,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontFamily: FontFamily.circularStd,
            color: ColorName.textNormal,
            fontSize: 16,
          ),
          bodyText2: TextStyle(
            fontFamily: FontFamily.circularStd,
            color: ColorName.textNormal,
            fontSize: 16,
          ),
          button: TextStyle(
            fontFamily: FontFamily.circularStd,
            color: ColorName.textNormal,
            fontSize: 16,
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: (locales, supportedLocales) {
        for (final locale in locales!) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }
        }

        return const Locale('vi', 'VN');
      },
      locale: Locale(language),
      initialRoute: '/init',
      routes: {
        '/init': (context) => const AppInit(),
        '/home-page': (context) => const HomePage(),
        '/sign-in': (context) => const SignIn(),
      },
      onGenerateRoute: onGenerateRoute,
    );
  }
}

typedef PageContentBuilder = Widget Function([
  Object? arguments,
]);
