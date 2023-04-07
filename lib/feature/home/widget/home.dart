import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Scaffold(
      backgroundColor: ColorName.pageBackground,
      // endDrawer: const EndDrawerWidget(),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

final indexPageViewHomeScreen =
    StateNotifierProvider((ref) => IndexPageViewHomeScreen());

class IndexPageViewHomeScreen extends StateNotifier<int> {
  IndexPageViewHomeScreen() : super(0);

  set value(int index) => state = index;
}
