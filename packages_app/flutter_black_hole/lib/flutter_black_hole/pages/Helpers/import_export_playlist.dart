import 'dart:convert';
import 'dart:io' as SystemIO;

import 'package:flutter/material.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';

import 'package:hive/hive.dart';
import 'package:ocean_common_module/ocean_common_module.dart';
import 'package:logging/logging.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter_black_hole/flutter_black_hole/pages/CustomWidgets/custom_widgets_index.dart';
import 'package:flutter_black_hole/flutter_black_hole/pages/Helpers/helpers_index.dart';

Future<void> exportPlaylist(
  BuildContext context,
  String playlistName,
  String showName,
) async {
  try {
    final String dirPath = await Picker.selectFolder(
      context: context,
      message: AppLocalizations.of(context).selectExportLocation,
    );
    if (dirPath == '') {
      if (!context.mounted) return;
      ShowSnackBar().showSnackBar(
        context,
        '${AppLocalizations.of(context).failedExport} "$showName"',
      );
      return;
    }
    await Hive.openBox(playlistName);
    final Box playlistBox = Hive.box(playlistName);
    final Map songsMap = playlistBox.toMap();
    final String songs = json.encode(songsMap);
    SystemIO.File file;
    try {
      file = await SystemIO.File('$dirPath/$showName.json')
          .create(recursive: true);
    } catch (e) {
      Logger.root.severe(
        'Error creating export playlist file. Retrying with file access permission',
      );
      await [
        Permission.manageExternalStorage,
      ].request();
      file = await SystemIO.File('$dirPath/$showName.json')
          .create(recursive: true);
    }
    await file.writeAsString(songs);
    if (!context.mounted) return;
    ShowSnackBar().showSnackBar(
      context,
      '${AppLocalizations.of(context).exported} "$showName"',
    );
  } catch (e) {
    Logger.root.severe('Error while exporting playlist', e);
    if (!context.mounted) return;
    ShowSnackBar().showSnackBar(
      context,
      AppLocalizations.of(context).failedExport,
    );
  }
}

Future<void> sharePlaylist(
  BuildContext context,
  String playlistName,
  String showName,
) async {
  final SystemIO.Directory appDir = await getApplicationDocumentsDirectory();
  final String temp = appDir.path;

  await Hive.openBox(playlistName);
  final Box playlistBox = Hive.box(playlistName);
  final Map songsMap = playlistBox.toMap();
  final String songs = json.encode(songsMap);
  final SystemIO.File file =
      await SystemIO.File('$temp/$showName.json').create(recursive: true);
  await file.writeAsString(songs);
  final files = <XFile>[XFile(file.path)];
  if (!context.mounted) return;
  await Share.shareXFiles(
    files,
    text: AppLocalizations.of(context).playlistShareText,
  );
  await Future.delayed(const Duration(seconds: 10), () {});
  if (await file.exists()) {
    await file.delete();
  }
}

Future<List> importFilePlaylist(
  BuildContext? context,
  List playlistNames, {
  String? path,
  bool pickFile = true,
}) async {
  try {
    String temp = '';
    if ((pickFile || path == null) && context != null) {
      try {
        temp = await Picker.selectFile(
          context: context,
          // ext: ['json'],
          message: AppLocalizations.of(context).selectJsonImport,
        );
      } catch (e) {
        if (context.mounted) {
          temp = await Picker.selectFile(
            context: context,
            message: AppLocalizations.of(context).selectJsonImport,
          );
        }
      }
    } else {
      if (path != null) {
        temp = path;
      }
    }
    if (temp == '') {
      Logger.root.severe('Error while importing playlist', 'path is empty');
      if (context != null && context.mounted) {
        ShowSnackBar().showSnackBar(
          context,
          AppLocalizations.of(context).failedImport,
        );
      }
      return playlistNames;
    }

    Logger.root.severe('Got playlist path', temp);
    final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');
    String playlistName = temp
        .split('/')
        .last
        .replaceAll('.json', '')
        .replaceAll(avoid, '')
        .replaceAll('  ', ' ');

    final SystemIO.File file = SystemIO.File(temp);
    final String finString = await file.readAsString();
    final Map songsMap = json.decode(finString) as Map;
    final List songs = songsMap.values.toList();
    // playlistBox.put(mediaItem.id.toString(), info);
    // Hive.box(play)

    if (playlistName.trim() == '') {
      playlistName = 'Playlist ${playlistNames.length}';
    }
    if (playlistNames.contains(playlistName)) {
      playlistName = '$playlistName (1)';
    }
    playlistNames.add(playlistName);

    await Hive.openBox(playlistName);
    final Box playlistBox = Hive.box(playlistName);
    await playlistBox.putAll(songsMap);
    await Hive.box('settings').put('playlistNames', playlistNames);

    addSongsCount(
      playlistName,
      songs.length,
      songs.length >= 4 ? songs.sublist(0, 4) : songs.sublist(0, songs.length),
    );

    if (context != null && context.mounted) {
      ShowSnackBar().showSnackBar(
        context,
        '${AppLocalizations.of(context).importSuccess} "$playlistName"',
      );
    }
    return playlistNames;
  } catch (e) {
    Logger.root.severe('Error while importing playlist', e);
    if (context != null && context.mounted) {
      ShowSnackBar().showSnackBar(
        context,
        '${AppLocalizations.of(context).failedImport}\nError: $e',
      );
    }
  }
  return playlistNames;
}
