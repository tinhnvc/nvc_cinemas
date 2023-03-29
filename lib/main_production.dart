import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/start.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.env);
  await start();
}
