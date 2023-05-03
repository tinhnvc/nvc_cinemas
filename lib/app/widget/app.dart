import 'package:nvc_cinemas/app/widget/app_init.dart';
import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:nvc_cinemas/feature/auth/widget/forgot_password.dart';
import 'package:nvc_cinemas/feature/auth/widget/sign_in.dart';
import 'package:nvc_cinemas/feature/auth/widget/sign_up.dart';
import 'package:nvc_cinemas/feature/auth/widget/sign_up_successful.dart';
import 'package:nvc_cinemas/feature/home/widget/home.dart';
import 'package:nvc_cinemas/feature/m_account/widget/add_account.dart';
import 'package:nvc_cinemas/feature/m_account/widget/edit_account.dart';
import 'package:nvc_cinemas/feature/m_category/widget/add_category.dart';
import 'package:nvc_cinemas/feature/m_category/widget/edit_category.dart';
import 'package:nvc_cinemas/feature/m_category/widget/m_category_page.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/add_movie.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/add_showtimes.dart';
import 'package:nvc_cinemas/feature/m_movie/widget/edit_movie.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/feature/m_promotion/widget/add_promotion.dart';
import 'package:nvc_cinemas/feature/m_promotion/widget/edit_promotion.dart';
import 'package:nvc_cinemas/feature/m_revenue/widget/revenue_detail.dart';
import 'package:nvc_cinemas/feature/m_room/model/room_model.dart';
import 'package:nvc_cinemas/feature/m_room/widget/add_room.dart';
import 'package:nvc_cinemas/feature/m_room/widget/edit_room.dart';
import 'package:nvc_cinemas/feature/m_seat/model/seat_type_model.dart';
import 'package:nvc_cinemas/feature/m_seat/widget/add_seat.dart';
import 'package:nvc_cinemas/feature/m_seat/widget/edit_seat.dart';
import 'package:nvc_cinemas/feature/m_ticket/widget/ticket_detail.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/widget/booking_by_movie.dart';
import 'package:nvc_cinemas/feature/movie/widget/booking_by_movie_detail.dart';
import 'package:nvc_cinemas/feature/movie/widget/movie_detail.dart';
import 'package:nvc_cinemas/feature/movie/widget/movie_page.dart';
import 'package:nvc_cinemas/feature/movie/widget/search_page.dart';
import 'package:nvc_cinemas/feature/payment/widget/payment_page.dart';
import 'package:nvc_cinemas/feature/promotion/widget/promotion_detail.dart';
import 'package:nvc_cinemas/feature/promotion/widget/promotion_page.dart';
import 'package:nvc_cinemas/feature/setting/widget/cinemas_info.dart';
import 'package:nvc_cinemas/feature/setting/widget/secure_policy.dart';
import 'package:nvc_cinemas/feature/setting/widget/setting_page.dart';
import 'package:nvc_cinemas/feature/setting/widget/term_of_use.dart';
import 'package:nvc_cinemas/feature/showtimes/widget/showtimes_page.dart';
import 'package:nvc_cinemas/feature/ticket/model/ticket_model.dart';
import 'package:nvc_cinemas/feature/ticket/widget/ticket_page.dart';
import 'package:nvc_cinemas/feature/user/widget/account_information.dart';
import 'package:nvc_cinemas/feature/user/widget/change_password.dart';
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
import 'package:nvc_cinemas/shared/widget/see_more_screen.dart';
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
      '/sign-up': ([Object? arguments]) => const SignUp(),
      '/sign-up-successful': ([Object? arguments]) => const SignUpSuccessful(),
      '/forgot-password': ([Object? arguments]) => const ForgotPassword(),
      '/home': ([Object? arguments]) => const Home(),
      '/movie-page': ([Object? arguments]) => const MoviePage(),
      '/showtimes-page': ([Object? arguments]) => const ShowtimesPage(),
      '/ticket-page': ([Object? arguments]) => const TicketPage(),
      '/promotion-page': ([Object? arguments]) => const PromotionPage(),
      '/see-more': ([Object? arguments]) => const SeeMoreScreen(),
      '/setting': ([Object? arguments]) => const Settings(),
      '/booking-by-movie': ([Object? arguments]) => BookingByMovie(
            movie: arguments! as MovieModel,
          ),
      '/booking-by-movie-detail': ([Object? arguments]) => BookingByMovieDetail(
            args: arguments! as Map<String, dynamic>,
          ),
      '/account-information': ([Object? arguments]) =>
          const AccountInformation(),
      '/payment': ([Object? arguments]) => PaymentPage(
            args: arguments! as Map<String, dynamic>,
          ),
      '/movie-detail': ([Object? arguments]) => MovieDetail(
            movie: arguments! as MovieModel,
          ),
      '/promotion-detail': ([Object? arguments]) =>
          PromotionDetail(promotion: arguments! as PromotionModel),
      '/change-password': ([Object? arguments]) => const ChangePassword(),
      '/m-category-page': ([Object? arguments]) => const MCategoryPage(),
      '/add-category': ([Object? arguments]) => const AddCategory(),
      '/edit-category': ([Object? arguments]) =>
          EditCategory(category: arguments! as CategoryModel),
      '/add-movie': ([Object? arguments]) => const AddMovie(),
      '/edit-movie': ([Object? arguments]) => EditMovie(
            movie: arguments! as MovieModel,
          ),
      '/add-showtimes': ([Object? arguments]) => AddShowtimes(
            movie: arguments! as MovieModel,
          ),
      '/add-room': ([Object? arguments]) => const AddRoom(),
      '/edit-room': ([Object? arguments]) => EditRoom(
            room: arguments! as RoomModel,
          ),
      '/add-account': ([Object? arguments]) => const AddAccount(),
      '/edit-account': ([Object? arguments]) => EditAccount(
            account: arguments! as User,
          ),
      '/add-seat': ([Object? arguments]) => const AddSeat(),
      '/edit-seat': ([Object? arguments]) => EditSeat(
            seatType: arguments! as SeatTypeModel,
          ),
      '/add-promotion': ([Object? arguments]) => const AddPromotion(),
      '/edit-promotion': ([Object? arguments]) =>
          EditPromotion(promotion: arguments! as PromotionModel),
      '/ticket-detail': ([Object? arguments]) =>
          TicketDetail(ticket: arguments! as TicketModel),
      '/revenue-detail': ([Object? arguments]) => RevenueDetail(
            movie: arguments! as MovieModel,
          ),
      '/term-of-use': ([Object? arguments]) => const TermOfUse(),
      '/secure-policy': ([Object? arguments]) => const SecurePolicy(),
      '/cinemas-info': ([Object? arguments]) => const CinemasInfo(),
      '/search-page': ([Object? arguments]) => const SearchPage(),
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
      debugShowCheckedModeBanner: false,
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
      // routes: {
      //   '/init': (context) => const AppInit(),
      //   '/home-page': (context) => const HomePage(),
      //   '/sign-in': (context) => const SignIn(),
      // },
      onGenerateRoute: onGenerateRoute,
    );
  }
}

typedef PageContentBuilder = Widget Function([
  Object? arguments,
]);
