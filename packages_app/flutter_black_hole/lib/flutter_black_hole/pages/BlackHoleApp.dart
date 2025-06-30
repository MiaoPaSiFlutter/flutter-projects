import 'dart:async';
import 'dart:io' as SystemIO;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';

import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hzy_common_module/hzy_common_module.dart';
import 'package:logging/logging.dart';
// import 'package:metadata_god/metadata_god.dart';
import 'package:sizer/sizer.dart';
import 'Constants/constants_index.dart';
import 'Helpers/helpers_index.dart';
import 'Providers/providers_index.dart';
import 'Screens/Common/routes.dart';
import 'Screens/Player/audioplayer.dart';
import 'theme/app_theme.dart';

class BlackHoleApp extends GetView<BlackHoleAppController> {
  const BlackHoleApp({super.key});

  @override
  BlackHoleAppController get controller => Get.put(BlackHoleAppController());

  @override
  Widget build(BuildContext context) {
    return MyAppWapper();
  }
}

class BlackHoleAppController extends GetxController {
  BlackHoleAppController();

  /// give access to currentContext
  BuildContext? get context => Get.context;
}

class MyAppWapper extends StatefulWidget {
  const MyAppWapper({super.key});

  @override
  _MyAppWapperState createState() => _MyAppWapperState();
}

class _MyAppWapperState extends State<MyAppWapper> {
  var _init = false;

  @override
  void initState() {
    super.initState();
    main();
  }

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Paint.enableDithering = true;

    if (SystemIO.Platform.isWindows ||
        SystemIO.Platform.isLinux ||
        SystemIO.Platform.isMacOS) {
      await Hive.initFlutter('BlackHole/Database');
    } else if (SystemIO.Platform.isIOS) {
      await Hive.initFlutter('Database');
    } else {
      await Hive.initFlutter();
    }
    for (final box in hiveBoxes) {
      await openHiveBox(
        box['name'].toString(),
        limit: box['limit'] as bool? ?? false,
      );
    }
    if (SystemIO.Platform.isAndroid) {
      setOptimalDisplayMode();
    }
    await startService();
    setState(() {
      _init = true;
    });
  }

  Future<void> setOptimalDisplayMode() async {
    // 将首选模式更改为最高刷新率 可保持当前分辨率
    await FlutterDisplayMode.setHighRefreshRate();
    // final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    // final DisplayMode active = await FlutterDisplayMode.active;

    // final List<DisplayMode> sameResolution = supported
    //     .where(
    //       (DisplayMode m) => m.width == active.width && m.height == active.height,
    //     )
    //     .toList()
    //   ..sort(
    //     (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
    //   );

    // final DisplayMode mostOptimalMode =
    //     sameResolution.isNotEmpty ? sameResolution.first : active;

    // await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  Future<void> startService() async {
    await initializeLogging();
    // MetadataGod.initialize();
    final audioHandlerHelper = AudioHandlerHelper();
    final AudioPlayerHandler audioHandler =
        await audioHandlerHelper.getAudioHandler();
    GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
    GetIt.I.registerSingleton<MyTheme>(MyTheme());
  }

  Future<void> openHiveBox(String boxName, {bool limit = false}) async {
    final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
      Logger.root.severe('Failed to open $boxName Box', error, stackTrace);
      final SystemIO.Directory dir = await getApplicationDocumentsDirectory();
      final String dirPath = dir.path;
      SystemIO.File dbFile = SystemIO.File('$dirPath/$boxName.hive');
      SystemIO.File lockFile = SystemIO.File('$dirPath/$boxName.lock');
      if (SystemIO.Platform.isWindows ||
          SystemIO.Platform.isLinux ||
          SystemIO.Platform.isMacOS) {
        dbFile = SystemIO.File('$dirPath/BlackHole/$boxName.hive');
        lockFile = SystemIO.File('$dirPath/BlackHole/$boxName.lock');
      }
      await dbFile.delete();
      await lockFile.delete();
      await Hive.openBox(boxName);
      throw 'Failed to open $boxName Box\nError: $error';
    });
    // clear box if it grows large
    if (limit && box.length > 500) {
      box.clear();
    }
  }

  /// Called when Doing Background Work initiated from Widget
  @pragma('vm:entry-point')
  Future<void> backgroundCallback(Uri? data) async {
    if (data?.host == 'controls') {
      final audioHandler = await AudioHandlerHelper().getAudioHandler();
      if (data?.path == '/play') {
        audioHandler.play();
      } else if (data?.path == '/pause') {
        audioHandler.pause();
      } else if (data?.path == '/skipNext') {
        audioHandler.skipToNext();
      } else if (data?.path == '/skipPrevious') {
        audioHandler.skipToPrevious();
      }

      // await HomeWidget.saveWidgetData<String>(
      //   'title',
      //   audioHandler?.mediaItem.value?.title,
      // );
      // await HomeWidget.saveWidgetData<String>(
      //   'subtitle',
      //   audioHandler?.mediaItem.value?.displaySubtitle,
      // );
      // await HomeWidget.updateWidget(name: 'BlackHoleMusicWidget');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _init
        ? MyApp()
        : const Center(
            child: Text("加载中。。。"),
          );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  // ignore: unreachable_from_main
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');
  late StreamSubscription _intentTextStreamSubscription;
  late StreamSubscription _intentDataStreamSubscription;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    _intentTextStreamSubscription.cancel();
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final String systemLangCode = SystemIO.Platform.localeName.substring(0, 2);
    final String? lang = Hive.box('settings').get('lang') as String?;
    if (lang == null &&
        LanguageCodes.languageCodes.values.contains(systemLangCode)) {
      _locale = Locale(systemLangCode);
    } else {
      _locale = Locale(LanguageCodes.languageCodes[lang ?? 'English'] ?? 'en');
    }

    AppTheme.currentTheme.addListener(() {
      setState(() {});
    });

    // if (SystemIO.Platform.isAndroid || SystemIO.Platform.isIOS) {
    //   // For sharing or opening urls/text coming from outside the app while the app is in the memory
    //   _intentTextStreamSubscription =
    //       ReceiveSharingIntent.getTextStream().listen(
    //     (String value) {
    //       Logger.root.info('Received intent on stream: $value');
    //       handleSharedText(value, navigatorKey);
    //     },
    //     onError: (err) {
    //       Logger.root.severe('ERROR in getTextStream', err);
    //     },
    //   );

    //   // For sharing or opening urls/text coming from outside the app while the app is closed
    //   ReceiveSharingIntent.getInitialText().then(
    //     (String? value) {
    //       Logger.root.info('Received Intent initially: $value');
    //       if (value != null) handleSharedText(value, navigatorKey);
    //     },
    //     onError: (err) {
    //       Logger.root.severe('ERROR in getInitialTextStream', err);
    //     },
    //   );

    //   // For sharing files coming from outside the app while the app is in the memory
    //   _intentDataStreamSubscription =
    //       ReceiveSharingIntent.getMediaStream().listen(
    //     (List<SharedMediaFile> value) {
    //       if (value.isNotEmpty) {
    //         for (final file in value) {
    //           if (file.path.endsWith('.json')) {
    //             final List playlistNames = Hive.box('settings')
    //                     .get('playlistNames')
    //                     ?.toList() as List? ??
    //                 ['Favorite Songs'];
    //             importFilePlaylist(
    //               null,
    //               playlistNames,
    //               path: file.path,
    //               pickFile: false,
    //             ).then(
    //               (value) => navigatorKey.currentState?.pushNamed('/playlists'),
    //             );
    //           }
    //         }
    //       }
    //     },
    //     onError: (err) {
    //       Logger.root.severe('ERROR in getDataStream', err);
    //     },
    //   );

    //   // For sharing files coming from outside the app while the app is closed
    //   ReceiveSharingIntent.getInitialMedia()
    //       .then((List<SharedMediaFile> value) {
    //     if (value.isNotEmpty) {
    //       for (final file in value) {
    //         if (file.path.endsWith('.json')) {
    //           final List playlistNames = Hive.box('settings')
    //                   .get('playlistNames')
    //                   ?.toList() as List? ??
    //               ['Favorite Songs'];
    //           importFilePlaylist(
    //             null,
    //             playlistNames,
    //             path: file.path,
    //             pickFile: false,
    //           ).then(
    //             (value) => navigatorKey.currentState?.pushNamed('/playlists'),
    //           );
    //         }
    //       }
    //     }
    //   });
    // }
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: AppTheme.themeMode == ThemeMode.system
            ? MediaQuery.platformBrightnessOf(context) == Brightness.dark
                ? Brightness.light
                : Brightness.dark
            : AppTheme.themeMode == ThemeMode.dark
                ? Brightness.light
                : Brightness.dark,
        systemNavigationBarIconBrightness:
            AppTheme.themeMode == ThemeMode.system
                ? MediaQuery.platformBrightnessOf(context) == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark
                : AppTheme.themeMode == ThemeMode.dark
                    ? Brightness.light
                    : Brightness.dark,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizerUtil.setScreenSize(constraints, orientation);
              return MaterialApp(
                title: 'BlackHole',
                restorationScopeId: 'blackhole',
                debugShowCheckedModeBanner: false,
                themeMode: AppTheme.themeMode,
                theme: AppTheme.lightTheme(
                  context: context,
                ),
                darkTheme: AppTheme.darkTheme(
                  context: context,
                ),
                locale: _locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: LanguageCodes.languageCodes.entries
                    .map((languageCode) => Locale(languageCode.value, ''))
                    .toList(),
                routes: namedRoutes,
                navigatorKey: navigatorKey,
                onGenerateRoute: (RouteSettings settings) {
                  if (settings.name == '/player') {
                    return PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => const PlayScreen(),
                    );
                  }
                  return HandleRoute.handleRoute(settings.name);
                },
              );
            },
          );
        },
      ),
    );
  }
}
