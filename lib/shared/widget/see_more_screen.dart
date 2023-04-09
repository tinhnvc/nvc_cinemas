import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/enum/navigation_item.dart';
import 'package:nvc_cinemas/shared/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/widget/app_bar_widget.dart';

class SeeMoreScreen extends ConsumerWidget {
  const SeeMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Scaffold(
      backgroundColor: ColorName.pageBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            AppBarWidget(title: context.l10n.other),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SeeMoreItem(
                        icon: Icons.sticky_note_2_sharp,
                        content: context.l10n.ticket,
                        onPressed: () =>
                            Navigator.pushNamed(context, '/ticket-page'),
                      ),
                      SeeMoreItem(
                        icon: Icons.percent_rounded,
                        content: context.l10n.promotions,
                        onPressed: () =>
                            Navigator.pushNamed(context, '/promotion-page'),
                      ),
                      SeeMoreItem(
                        icon: Icons.settings,
                        content: context.l10n.settings,
                        onPressed: () =>
                            Navigator.pushNamed(context, '/setting'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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

class SeeMoreItem extends StatelessWidget {
  const SeeMoreItem({
    Key? key,
    required this.icon,
    required this.content,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 3,
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 25,
                color: const Color(0xFF697492),
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Color(0xFF697492)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
