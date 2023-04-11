/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsEnvGen {
  const $AssetsEnvGen();

  /// File path: assets/env/.env.production
  String get env => 'assets/env/.env.production';

  /// List of all assets
  List<String> get values => [env];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/account-infor.png
  AssetGenImage get accountInfor =>
      const AssetGenImage('assets/images/account-infor.png');

  /// File path: assets/images/book-ticket.png
  AssetGenImage get bookTicket =>
      const AssetGenImage('assets/images/book-ticket.png');

  /// File path: assets/images/carousel_1.png
  AssetGenImage get carousel1 =>
      const AssetGenImage('assets/images/carousel_1.png');

  /// File path: assets/images/carousel_1j.jpg
  AssetGenImage get carousel1j =>
      const AssetGenImage('assets/images/carousel_1j.jpg');

  /// File path: assets/images/carousel_2.png
  AssetGenImage get carousel2 =>
      const AssetGenImage('assets/images/carousel_2.png');

  /// File path: assets/images/carousel_2j.jpg
  AssetGenImage get carousel2j =>
      const AssetGenImage('assets/images/carousel_2j.jpg');

  /// File path: assets/images/carousel_3.png
  AssetGenImage get carousel3 =>
      const AssetGenImage('assets/images/carousel_3.png');

  /// File path: assets/images/carousel_3j.jpg
  AssetGenImage get carousel3j =>
      const AssetGenImage('assets/images/carousel_3j.jpg');

  /// File path: assets/images/change-password.png
  AssetGenImage get changePassword =>
      const AssetGenImage('assets/images/change-password.png');

  /// File path: assets/images/chat.png
  AssetGenImage get chat => const AssetGenImage('assets/images/chat.png');

  /// File path: assets/images/google-logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/images/google-logo.png');

  /// File path: assets/images/icon-1024x1024.png
  AssetGenImage get icon1024x1024 =>
      const AssetGenImage('assets/images/icon-1024x1024.png');

  /// File path: assets/images/logo-png.png
  AssetGenImage get logoPng =>
      const AssetGenImage('assets/images/logo-png.png');

  /// File path: assets/images/payment-gateway.png
  AssetGenImage get paymentGateway =>
      const AssetGenImage('assets/images/payment-gateway.png');

  /// File path: assets/images/payment_qr.png
  AssetGenImage get paymentQr =>
      const AssetGenImage('assets/images/payment_qr.png');

  /// File path: assets/images/promotions.png
  AssetGenImage get promotions =>
      const AssetGenImage('assets/images/promotions.png');

  /// File path: assets/images/see-more.png
  AssetGenImage get seeMore =>
      const AssetGenImage('assets/images/see-more.png');

  /// File path: assets/images/settings.png
  AssetGenImage get settings =>
      const AssetGenImage('assets/images/settings.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        accountInfor,
        bookTicket,
        carousel1,
        carousel1j,
        carousel2,
        carousel2j,
        carousel3,
        carousel3j,
        changePassword,
        chat,
        googleLogo,
        icon1024x1024,
        logoPng,
        paymentGateway,
        paymentQr,
        promotions,
        seeMore,
        settings
      ];
}

class Assets {
  Assets._();

  static const $AssetsEnvGen env = $AssetsEnvGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
