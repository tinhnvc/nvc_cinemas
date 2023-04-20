import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provder.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';

class Settings extends ConsumerWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final isVietnamese = ref.watch(appLanguage)! as bool;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorName.pageBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/settings.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: ColorName.pageBackground.withOpacity(0.7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ArrowBackTitle(
                          title: context.l10n.settings,
                          textSize: 19,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.l10n.language.toUpperCase(),
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          // color: Colors.white60,
                          child: Column(
                            children: [
                              ListTile(
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onTap: () async {
                                  ref.read(appLanguage.notifier).changed = true;
                                  FunctionUtil.changeLanguageApp(ref, 'vi');
                                },
                                title: Text(
                                  context.l10n.vi,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isVietnamese
                                        ? const Color(0xFF363E59)
                                        : const Color(0xFF697392),
                                  ),
                                ),
                                leading: SizedBox(
                                  width: 25,
                                  height: 20,
                                  child: Image.asset(
                                    'icons/flags/png/vn.png',
                                    package: 'country_icons',
                                  ),
                                ),
                                trailing: isVietnamese
                                    ? const Icon(
                                        Icons.done,
                                        size: 24,
                                        color: Color(0xFF6CB28E),
                                      )
                                    : null,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                tileColor: Colors.white60,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onTap: () async {
                                  ref.read(appLanguage.notifier).changed =
                                      false;
                                  FunctionUtil.changeLanguageApp(ref, 'en');
                                },
                                title: Text(
                                  context.l10n.en,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isVietnamese
                                        ? const Color(0xFF363E59)
                                        : const Color(0xFF697392),
                                  ),
                                ),
                                leading: SizedBox(
                                  width: 25,
                                  height: 20,
                                  child: Image.asset(
                                    'icons/flags/png/gb.png',
                                    package: 'country_icons',
                                  ),
                                ),
                                trailing: !isVietnamese
                                    ? const Icon(
                                        Icons.done,
                                        size: 24,
                                        color: Color(0xFF6CB28E),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.l10n.other.toUpperCase(),
                          style: TextStyle(
                            color: ColorName.btnText,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        rowButton(
                          content: context.l10n.version,
                          isVersion: true,
                          onPressed: () {},
                        ),
                        rowButton(
                          content: context.l10n.termOfUse,
                          onPressed: () =>
                              Navigator.pushNamed(context, '/term-of-use'),
                        ),
                        rowButton(
                          content: context.l10n.securePolicy,
                          onPressed: () =>
                              Navigator.pushNamed(context, '/secure-policy'),
                        ),
                        rowButton(
                          content: context.l10n.cinemasInfo,
                          onPressed: () =>
                              Navigator.pushNamed(context, '/cinemas-info'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInformation({
    required String title,
    required String content,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.6,
            child: Text(
              content,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 15,
                color: ColorName.textNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowButton({
    required String content,
    required VoidCallback onPressed,
    bool? isVersion = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: ColorName.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content,
              style: TextStyle(
                color: ColorName.btnText,
                fontSize: 16,
              ),
            ),
            Container(
              child: Row(
                children: [
                  if (isVersion ?? false)
                    Text(
                      '1.0.0',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  isVersion!
                      ? SizedBox()
                      : CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 17,
                            color: ColorName.textNormal,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
