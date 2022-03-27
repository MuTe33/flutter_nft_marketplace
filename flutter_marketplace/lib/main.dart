import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_marketplace/feature/app/nft_marketplace_app.dart';
import 'package:flutter_marketplace/locator.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details, forceReport: true);
      };

      initSyncDependencies();

      runApp(const NftMarketplaceApp());
    },
    (e, s) => FlutterError.reportError(
      FlutterErrorDetails(exception: e, stack: s),
    ),
  );
}
