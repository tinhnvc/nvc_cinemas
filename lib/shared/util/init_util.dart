import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/auth/model/user.dart';
import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/auth/provider/roles_provider.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/time_provider.dart';
import 'package:nvc_cinemas/feature/m_promotion/model/promotion_model.dart';
import 'package:nvc_cinemas/feature/m_promotion/provider/promotion_provider.dart';
import 'package:nvc_cinemas/feature/m_room/model/room_model.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_room_provider.dart';
import 'package:nvc_cinemas/feature/m_room/provider/m_seat_provider.dart';
import 'package:nvc_cinemas/feature/m_seat/model/seat_type_model.dart';
import 'package:nvc_cinemas/feature/m_seat/provider/seat_type_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/movie_rating_provider.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/repository/language_repository.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provider.dart';
import 'package:uuid/uuid.dart';

class InitUtil {
  static void initSignUpForm(
    WidgetRef ref,
  ) {
    final formGroup = ref.read(authProvider).signUpForm;
    formGroup.control('email').value = ' ';
    formGroup.control('password').value = ' ';
    formGroup.control('phoneNumber').value = ' ';
    formGroup.control('fullName').value = ' ';
    formGroup.control('gender').value = 'unknown';
    formGroup.control('yob').value = ' ';
    formGroup.reset();
    ref
      ..refresh(isAcceptTerms)
      ..refresh(genderSignUpProvider);
  }

  static void initSetting(WidgetRef ref) async {
    final languageSave =
        await ref.read(languageRepositoryProvider).fetchLanguage();
    ref.read(appLanguage.notifier).changed =
        languageSave == 'vi' ? true : false;
  }

  static void initComment({
    required WidgetRef ref,
    required String userId,
    required String movieId,
  }) async {
    final formGroup = ref.read(movieRatingFormProvider).addCommentForm;
    formGroup.control('userId').value = userId;
    formGroup.control('movieId').value = movieId;
    formGroup.control('star').value = '5';
    formGroup.control('comment').value = '';
  }

  static void initBookingByMovie({
    required WidgetRef ref,
  }) async {
    ref
        .read(dayOfWeekProvider.notifier)
        .statusChangedDefault('c1d8b61c-fc54-4ec9-a9af-16ce093c93a1');
  }

  static void initBookingByMovieDetail({
    required WidgetRef ref,
    required TimeModel time,
  }) async {
    ref.read(seatsProvider.notifier)
      ..cleanStatus()
      ..cleanStatusSold();
    final soldSeats =
        ref.read(ticketsProvider.notifier).getSeatsIdByTimeId(time.id!);
    ref.read(seatsProvider.notifier).setSoldSeat(soldSeats);
  }

  static void initEditCategory({
    required WidgetRef ref,
    required CategoryModel category,
  }) async {
    final formGroup = ref.read(categoryFormProvider).addCategoryForm;
    formGroup.control('categoryName').value = category.categoryName;
    formGroup.control('categoryNameEn').value = category.categoryNameEn;
    formGroup.control('description').value = category.description;
    formGroup.control('active').value = category.active.toString();
  }

  static void initAddCategory({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(categoryFormProvider).addCategoryForm..reset();
    formGroup.control('active').value = 'true';
  }

  static void initAddPromotion({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(promotionFormProvider).addPromotionForm..reset();
    formGroup.control('active').value = 'true';
    formGroup.control('code').value = '';
    ref
      ..refresh(startTimeAddPromotionProvider)
      ..refresh(endTimeAddPromotionProvider)
      ..refresh(codeAddPromotionProvider)
      ..refresh(imageAddPromotionProvider);
  }

  static void initEditPromotion({
    required WidgetRef ref,
    required PromotionModel promotion,
  }) async {
    final formGroup = ref.read(promotionFormProvider).addPromotionForm;
    formGroup.control('name').value = promotion.name;
    formGroup.control('content').value = promotion.content;
    formGroup.control('image').value = promotion.image;
    formGroup.control('code').value = promotion.code;
    formGroup.control('startTime').value = promotion.startTime.toString();
    formGroup.control('endTime').value = promotion.endTime.toString();
    formGroup.control('active').value = promotion.active.toString();

    ref
        .read(startTimeAddPromotionProvider.notifier)
        .update('${promotion.startTime}');
    ref
        .read(endTimeAddPromotionProvider.notifier)
        .update('${promotion.endTime}');
    ref.read(imageAddPromotionProvider.notifier).update('${promotion.image}');
    ref.read(codeAddPromotionProvider.notifier).update('${promotion.code}');
  }

  static void initAddSeatType({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(seatTypeFormProvider).addSeatTypeForm..reset();
  }

  static void initEditSeatType({
    required WidgetRef ref,
    required SeatTypeModel seatType,
  }) async {
    final formGroup = ref.read(seatTypeFormProvider).addSeatTypeForm;
    formGroup.control('typeName').value = seatType.typeName;
    formGroup.control('price').value = seatType.price.toString();
    formGroup.control('otherPrice').value = seatType.otherPrice.toString();
    formGroup.control('active').value = seatType.active.toString();
  }

  static void initAddAccount({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(userFormProvider).addAccountForm..reset();
    final customRole = ref.read(rolesProvider.notifier).getByName('Khách hàng');
    ref.read(roleAddAccountProvider.notifier).update('Khách hàng');
    ref.read(roleModelAddAccountProvider.notifier).fetchUser(customRole);
  }

  static void initEditAccount({
    required WidgetRef ref,
    required BuildContext context,
    required User user,
  }) async {
    final formGroup = ref.read(userFormProvider).addAccountForm;
    formGroup.control('email').value = user.email;
    formGroup.control('password').value = user.password;
    formGroup.control('phoneNumber').value = user.phoneNumber;
    formGroup.control('fullName').value = user.fullName;
    formGroup.control('gender').value = user.gender;
    formGroup.control('yob').value = user.yob;
    ref.read(genderAddAccountProvider.notifier).update(
        user.gender! == 'male' ? context.l10n.male : context.l10n.female);
    formGroup.control('email').markAsEnabled();
  }

  static void initAddMovie({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(movieFormProvider).addMovieForm..reset();
    formGroup.control('category').value =
        'd44e5235-566c-46e0-a947-0df21794aafb';
    formGroup.control('type').value = 'P-';
    formGroup.control('dimension').value = '2D';
    ref
      ..refresh(categoryAddMovieProvider)
      ..refresh(ageTypeAddMovieProvider)
      ..refresh(dimensionTypeAddMovieProvider)
      ..refresh(startTimeAddMovieProvider)
      ..refresh(endTimeAddMovieProvider)
      ..refresh(imageAddMovieProvider);
  }

  static void initEditMovie({
    required WidgetRef ref,
    required BuildContext context,
    required MovieModel movie,
  }) async {
    final formGroup = ref.read(movieFormProvider).addMovieForm..reset();
    formGroup.control('category').value = movie.category;
    formGroup.control('movieNameVi').value = movie.movieNameVi;
    formGroup.control('movieNameEn').value = movie.movieNameEn;
    formGroup.control('image').value = movie.image;
    formGroup.control('description').value = movie.description;
    formGroup.control('duration').value = movie.duration;
    formGroup.control('director').value = movie.director;
    formGroup.control('actor').value = movie.actor;
    formGroup.control('type').value = movie.type;
    formGroup.control('dimension').value = movie.dimension;
    formGroup.control('startTime').value = movie.startTime.toString();
    formGroup.control('endTime').value = movie.endTime.toString();
    final category =
        ref.read(categoriesProvider.notifier).getById(movie.category!);
    ref.read(categoryAddMovieProvider.notifier).update(category.categoryName!);
    ref.read(ageTypeAddMovieProvider.notifier).update(movie.type!);
    ref.read(dimensionTypeAddMovieProvider.notifier).update(movie.dimension!);
    ref
        .read(startTimeAddMovieProvider.notifier)
        .update(movie.startTime.toString());
    ref.read(endTimeAddMovieProvider.notifier).update(movie.endTime.toString());
    ref.read(imageAddMovieProvider.notifier).update(movie.image!);
  }

  static void initMTicketPage({
    required WidgetRef ref,
  }) async {
    ref
      ..refresh(startTimeFilterMovieProvider)
      ..refresh(endTimeFilterMovieProvider);
  }

  static void initAddShowtime({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(timeFormProvider).addShowtimeForm..reset();
    ref
      ..refresh(roomAddShowtimeProvider)
      ..refresh(startTimeAddShowtimeProvider)
      ..refresh(endTimeAddShowtimeProvider)
      ..refresh(isShowtimeAvailableProvider);
    final rooms = ref.watch(roomsProvider);
    final roomsDropdownList = <RoomModel>[];
    if (rooms.isNotEmpty) {
      for (final item in rooms) {
        if (item.active!) {
          roomsDropdownList.add(item);
        }
      }
    }
    formGroup.control('roomId').value =
        roomsDropdownList[0].id ?? 'c61c9214-91fa-4f6d-b775-7a59fc587ba4';
  }

  static void initEditShowtime({
    required WidgetRef ref,
    required TimeModel time,
  }) async {
    final formGroup = ref.read(timeFormProvider).addShowtimeForm..reset();
    final room = ref.read(roomsProvider.notifier).getById(time.roomId!);
    ref.read(roomAddShowtimeProvider.notifier).update(room.name ?? 'P01');
    ref
        .read(startTimeAddShowtimeProvider.notifier)
        .update(time.from.toString());
    ref.read(endTimeAddShowtimeProvider.notifier).update(time.to.toString());
    ref.read(isShowtimeAvailableProvider.notifier).changed = true;
    formGroup.control('roomId').value = room.id;
    formGroup.control('from').value = time.from.toString();
    formGroup.control('to').value = time.to.toString();
  }

  static void initAddRoom({
    required WidgetRef ref,
  }) async {
    final formGroup = ref.read(roomFormProvider).addRoomForm..reset();
    formGroup.control('size').value = '3 x 4';
    formGroup.control('seatAmount').value = '12';
    ref
      ..refresh(widthAddRoomProvider)
      ..refresh(heightAddRoomProvider);
    ref.read(roomIdProvider.notifier).update(Uuid().v4());
    ref.read(seatsAddRoomProvider.notifier).fetchRooms(ref, 3, 4);
  }

  static void initEditRoom({
    required WidgetRef ref,
    required BuildContext context,
    required RoomModel room,
  }) async {
    final formGroup = ref.read(roomFormProvider).addRoomForm..reset();
    formGroup.control('roomName').value = room.name;
    formGroup.control('size').value = room.size;
    formGroup.control('seatAmount').value = room.seatAmount.toString();
    final height = room.size!.split(' x ')[0];
    final width = room.size!.split(' x ')[1];
    ref.read(heightAddRoomProvider.notifier).update(height);
    ref.read(widthAddRoomProvider.notifier).update(width);
    final oldSeats = ref.read(seatsProvider.notifier).getByRoomId(room.id!);
    ref.read(seatsAddRoomProvider.notifier).fetchOldList(oldSeats);
  }

  static void initEditCustomerInfor({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final user = ref.watch(userProvider);
    final formGroup = ref.read(userFormProvider).editProfileForm..reset();
    formGroup.control('password').value = user.password;
    formGroup.control('fullName').value = user.fullName;
    formGroup.control('phoneNumber').value = user.phoneNumber;
    formGroup.control('gender').value = user.gender;
    formGroup.control('yob').value = user.yob;
    ref.read(genderEditProfileProvider.notifier).update(
        user.gender! == 'male' ? context.l10n.male : context.l10n.female);
  }

  static void initChangePassword({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final formGroup = ref.read(userFormProvider).editPasswordForm..reset();
  }
}
