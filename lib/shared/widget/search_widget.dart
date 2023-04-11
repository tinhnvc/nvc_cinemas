import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/gen/fonts.gen.dart';

class SearchWidget extends ConsumerWidget {
  const SearchWidget({required this.searchHint, Key? key}) : super(key: key);

  final String searchHint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorName.primary.withOpacity(0.3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorName.textNormal,
                    fontFamily: FontFamily.circularStd,
                  ),
                  decoration: InputDecoration(
                      hintText: '$searchHint...', border: InputBorder.none),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
              const CircleAvatar(
                backgroundColor: ColorName.primary,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
