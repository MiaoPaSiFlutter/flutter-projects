import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_black_hole/flutter_black_hole/pages/CustomWidgets/custom_widgets_index.dart';
import 'package:flutter_black_hole/flutter_black_hole/pages/Screens/Player/audioplayer.dart';

void addToNowPlaying({
  required BuildContext context,
  required MediaItem mediaItem,
  bool showNotification = true,
}) {
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
  final MediaItem? currentMediaItem = audioHandler.mediaItem.value;
  if (currentMediaItem != null &&
      currentMediaItem.extras!['url'].toString().startsWith('http')) {
    if (audioHandler.queue.value.contains(mediaItem) && showNotification) {
      ShowSnackBar().showSnackBar(
        context,
        AppLocalizations.of(context).alreadyInQueue,
      );
    } else {
      audioHandler.addQueueItem(mediaItem);

      if (showNotification) {
        ShowSnackBar().showSnackBar(
          context,
          AppLocalizations.of(context).addedToQueue,
        );
      }
    }
  } else {
    if (showNotification) {
      ShowSnackBar().showSnackBar(
        context,
        currentMediaItem == null
            ? AppLocalizations.of(context).nothingPlaying
            : AppLocalizations.of(context).cantAddToQueue,
      );
    }
  }
}

void playNext(
  MediaItem mediaItem,
  BuildContext context,
) {
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
  final MediaItem? currentMediaItem = audioHandler.mediaItem.value;
  if (currentMediaItem != null &&
      currentMediaItem.extras!['url'].toString().startsWith('http')) {
    final queue = audioHandler.queue.value;
    if (queue.contains(mediaItem)) {
      audioHandler.moveQueueItem(
        queue.indexOf(mediaItem),
        queue.indexOf(currentMediaItem) + 1,
      );
    } else {
      audioHandler.addQueueItem(mediaItem).then(
            (value) => audioHandler.moveQueueItem(
              queue.length,
              queue.indexOf(currentMediaItem) + 1,
            ),
          );
    }

    ShowSnackBar().showSnackBar(
      context,
      '"${mediaItem.title}" ${AppLocalizations.of(context).willPlayNext}',
    );
  } else {
    ShowSnackBar().showSnackBar(
      context,
      currentMediaItem == null
          ? AppLocalizations.of(context).nothingPlaying
          : AppLocalizations.of(context).cantAddToQueue,
    );
  }
}
