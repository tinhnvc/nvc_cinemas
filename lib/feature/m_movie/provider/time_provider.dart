import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_movie/model/time_model.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/movie/provider/day_of_week_provder.dart';
import 'package:nvc_cinemas/shared/link/times.dart';

final timesProvider = StateNotifierProvider<MoviesNotifier, List<TimeModel>>(
  (ref) => MoviesNotifier(),
);

class MoviesNotifier extends StateNotifier<List<TimeModel>> {
  MoviesNotifier() : super([]) {
    fetchTimes();
  }

  Future<void> fetchTimes() async {
    final timesFetch = timesFromJson(times);
    state = timesFetch;
  }

  List<TimeModel> getByDay({
    required WidgetRef ref,
    required String movieId,
  }) {
    var result = <TimeModel>[];
    final dow = ref.read(dayOfWeekProvider.notifier).getSelected();
    final movie = ref.read(moviesProvider.notifier).getById(movieId);
    if (dow.id != null) {
      final startTime = dow.day;
      final endTime = DateTime.fromMillisecondsSinceEpoch(dow.day!)
          .add(const Duration(days: 1))
          .millisecondsSinceEpoch;
      for (final item in state) {
        if (item.movieId == movieId &&
            item.from! > startTime! &&
            item.to! < endTime &&
            item.from! > DateTime.now().millisecondsSinceEpoch) {
          result.add(item);
        }
      }
    }
    return result..sort((a, b) => a.from!.compareTo(b.from!));
  }

//
// MovieModel getById(String id) {
//   var movie = const MovieModel();
//   if (state.isNotEmpty) {
//     for (final item in state) {
//       if (item.id == id) {
//         movie = item;
//       }
//     }
//   }
//
//   return movie;
// }
}
