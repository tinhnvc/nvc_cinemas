import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/feature/m_revenue/provider/revenue_provider.dart';
import 'package:nvc_cinemas/feature/ticket/provider/ticket_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/select/selectable_text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final ratio = height / size.width;
    final currentSelected = ref.watch(navigationProvider)! as NavigationItem;

    final user = ref.watch(userProvider);
    var role = 'customer';
    if (user.role != null) {
      role = user.role!.roleName!;
    }
    final isCustomer = role != 'admin' && role != 'manager';

    return Drawer(
      backgroundColor: ColorName.primary,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.zero,
            children: [
              FittedBox(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // InitUtil.initSettingProfile(context, ref);
                        Navigator.pushNamed(
                          context,
                          '/account-information',
                        );
                        selectItem(context, ref, NavigationItem.home);
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFB7C3FC),
                        radius: 30,
                        child: Text(
                          user.fullName != null
                              ? ref.read(userProvider.notifier).getSortName()
                              : 'C',
                          style: const TextStyle(
                            color: Color(0xFF4B5574),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableTextCustom(
                          text: user.fullName != null
                              ? '${user.fullName}'
                              : context.l10n.customer,
                          selectionColor: Colors.white.withOpacity(0.4),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              buildNavigationItemDrawer(
                context: context,
                ref: ref,
                title: context.l10n.accountInfo,
                currentSelected: currentSelected,
                item: NavigationItem.personalAccount,
                icon: Icons.person,
              ),
              buildNavigationItemDrawer(
                context: context,
                ref: ref,
                title: context.l10n.settings,
                currentSelected: currentSelected,
                item: NavigationItem.settings,
                icon: Icons.settings,
              ),
              const Divider(
                color: Colors.white,
              ),
              if (isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title: context.l10n.home,
                  currentSelected: currentSelected,
                  item: NavigationItem.home,
                  icon: Icons.home,
                ),
              if (isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title: context.l10n.movie,
                  currentSelected: currentSelected,
                  item: NavigationItem.movie,
                  icon: Icons.video_collection,
                ),
              if (isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title: context.l10n.showtimes,
                  currentSelected: currentSelected,
                  item: NavigationItem.showtimes,
                  icon: Icons.date_range,
                ),
              if (isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title: context.l10n.ticket,
                  currentSelected: currentSelected,
                  item: NavigationItem.ticket,
                  icon: Icons.sticky_note_2_sharp,
                ),
              if (isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title: context.l10n.promotions,
                  currentSelected: currentSelected,
                  item: NavigationItem.promotions,
                  icon: Icons.percent,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.categories.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mCategory,
                  icon: Icons.category,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.movie.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mMovie,
                  icon: Icons.videocam_rounded,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.rooms.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mRoom,
                  icon: Icons.dataset,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.account.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mAccount,
                  icon: Icons.supervisor_account,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.seat.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mSeat,
                  icon: Icons.chair,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.promotions.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mPromotion,
                  icon: Icons.percent_rounded,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.ticket.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mTicket,
                  icon: Icons.sticky_note_2_sharp,
                ),
              if (!isCustomer)
                buildNavigationItemDrawer(
                  context: context,
                  ref: ref,
                  title:
                      '${context.l10n.manage} ${context.l10n.revenue.toLowerCase()}',
                  currentSelected: currentSelected,
                  item: NavigationItem.mRevenue,
                  icon: Icons.stacked_bar_chart,
                ),
              const Divider(
                color: Colors.white,
              ),
              ListTile(
                textColor: Colors.white,
                iconColor: Colors.white,
                leading: const Icon(
                  Icons.logout,
                  size: 20,
                ),
                title: Text(
                  context.l10n.logout,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  // InitUtil.initLogOut(ref);
                  ref.read(authProvider).logout();
                  selectItem(context, ref, NavigationItem.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: long-parameter-list
  Widget buildNavigationItemDrawer({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required NavigationItem currentSelected,
    required NavigationItem item,
    required IconData icon,
  }) {
    final isSelected = currentSelected == item;
    final user = ref.watch(userProvider);

    return ListTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      selected: isSelected,
      selectedColor: Colors.white,
      selectedTileColor: Colors.white24,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        selectItem(context, ref, item);

        if (item == NavigationItem.showtimes) {
          InitUtil.initBookingByMovie(ref: ref);
        }

        if (item == NavigationItem.mRevenue) {
          ref.refresh(isSelectRevenueMovieProvider);
        }

        if (item == NavigationItem.personalAccount) {
          // InitUtil.initSettingProfile(context, ref);
          Navigator.pushNamed(
            context,
            '/account-information',
          );
          selectItem(context, ref, NavigationItem.home);

          return;
        }
        if (item == NavigationItem.settings) {
          InitUtil.initSetting(ref);
          Navigator.pushNamed(
            context,
            '/setting',
          );
          selectItem(context, ref, NavigationItem.home);

          return;
        }
        if (item == NavigationItem.promotions) {
          // InitUtil.initSettingProfile(context, ref);
          Navigator.pushNamed(
            context,
            '/promotion-page',
          );
          selectItem(context, ref, NavigationItem.home);

          return;
        }
        if (item == NavigationItem.ticket) {
          print('rem');
          ref.read(ticketsProvider.notifier).cancelTicketOverTime(ref);

          return;
        }
        if (item == NavigationItem.mTicket) {
          print('rem');
          ref.read(ticketsProvider.notifier).cancelTicketOverTime(ref);

          return;
        }
        if (item == NavigationItem.ticket) {
          // InitUtil.initSettingProfile(context, ref);
          Navigator.pushNamed(
            context,
            '/ticket-page',
          );
          selectItem(context, ref, NavigationItem.home);

          return;
        }
      },
    );
  }

  void selectItem(BuildContext context, WidgetRef ref, NavigationItem item) {
    ref.watch(navigationProvider.notifier).setNavigationItem(item);
  }

// void initSettingProfile(BuildContext context, WidgetRef ref) {
//   final user = ref.watch(userProvider);
//   final formGroupEditProfile = ref.read(profileFormProvider).editProfileForm;
//   final formGroupEditCompany = ref.read(profileFormProvider).editCompanyForm;
//   formGroupEditProfile.control('name').value = user.fullName;
//   formGroupEditProfile.control('password').value = '*****';
//   formGroupEditProfile.control('email').value = user.email;
//   formGroupEditProfile.control('phone').value = user.phone;
//   formGroupEditProfile.control('ext').value = user.ext;
//   formGroupEditProfile.control('desc').value = user.desc;
//   formGroupEditProfile.control('language').value = user.language;
//
//   formGroupEditCompany.control('companyName').value =
//       user.client!.companyName;
//   formGroupEditCompany.control('email').value = user.client!.email;
//   formGroupEditCompany.control('phone').value = user.client!.phone;
//   formGroupEditCompany.control('domain').value = user.client!.domain;
//
//   TextFieldSettingsController.disableEditPersonalInformation(ref);
//   TextFieldSettingsController.disableEditCompanyInformation(ref);
// }
}
