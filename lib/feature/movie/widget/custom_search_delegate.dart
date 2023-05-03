import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate(this.movies);

  final List<MovieModel> movies;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<MovieModel> matchQuery = [];
    for (var item in movies) {
      if (item.movieNameVi!.toLowerCase().contains(query.toLowerCase()) &&
          query != '') {
        matchQuery.add(item);
      }
    }

    if (matchQuery.isEmpty) {
      return Center(
        child: Text(
          'Không tìm thấy kết quả nào',
          style: TextStyle(
            color: ColorName.btnText,
            fontSize: 15,
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            var result = matchQuery[index];
            return ListTile(
                title: Text(
                  result.movieNameVi!,
                  style: TextStyle(
                    color: ColorName.btnText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${result.duration} ${context.l10n.minutes.toLowerCase()}',
                  style: TextStyle(
                    color: ColorName.btnText,
                    fontSize: 15,
                  ),
                ),
                leading: result.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          File(result.image!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Assets.images.logoPng
                        .image(width: 100, fit: BoxFit.contain),
                trailing: Icon(
                  Icons.date_range_rounded,
                  size: 22,
                  color: ColorName.textNormal,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/booking-by-movie',
                      arguments: result);
                });
          });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in movies) {
      if (item.movieNameVi!.toLowerCase().contains(query.toLowerCase()) &&
          query != '') {
        matchQuery.add(item.movieNameVi!);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(
              result,
              style: TextStyle(
                color: ColorName.btnText,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.north_west,
                color: Colors.grey,
              ),
              onPressed: () => query = result,
            ),
            onTap: () {
              query = result;
            },
          );
        });
  }

  @override
  String? get searchFieldLabel => 'Nhập tên phim, đạo diễn, diễn viên...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorName.pageBackground,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: ColorName.btnText,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
