import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_black_hole/flutter_black_hole.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:flutter_black_hole/flutter_black_hole/pages/CustomWidgets/custom_widgets_index.dart';
import 'package:flutter_black_hole/flutter_black_hole/pages/Helpers/helpers_index.dart';

class AddToOffPlaylist {
  OfflineAudioQuery offlineAudioQuery = OfflineAudioQuery();

  Future<void> addToOffPlaylist(BuildContext context, int audioId) async {
    List<PlaylistModel> playlistDetails =
        await offlineAudioQuery.getPlaylists();
    if (!context.mounted) return;
    showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return BottomGradientContainer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).createPlaylist),
                  leading: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: SizedBox.square(
                      dimension: 50,
                      child: Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? null
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showTextInputDialog(
                      context: context,
                      keyboardType: TextInputType.text,
                      title: AppLocalizations.of(context).createNewPlaylist,
                      onSubmitted: (String value, BuildContext context) async {
                        await offlineAudioQuery.createPlaylist(name: value);
                        playlistDetails =
                            await offlineAudioQuery.getPlaylists();

                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                if (playlistDetails.isEmpty)
                  const SizedBox()
                else
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: playlistDetails.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: QueryArtworkWidget(
                            id: playlistDetails[index].id,
                            type: ArtworkType.PLAYLIST,
                            keepOldArtwork: true,
                            artworkBorder: BorderRadius.circular(7.0),
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: Image(
                                  fit: BoxFit.cover,
                                  height: 50.0,
                                  width: 50.0,
                                  image: AssetImage(
                                      Utils.assets('images/cover.jpg'))),
                            ),
                          ),
                        ),
                        title: Text(
                          playlistDetails[index].playlist,
                        ),
                        subtitle: Text(
                          '${playlistDetails[index].numOfSongs} Songs',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          offlineAudioQuery.addToPlaylist(
                            playlistId: playlistDetails[index].id,
                            audioId: audioId,
                          );
                          ShowSnackBar().showSnackBar(
                            context,
                            '${AppLocalizations.of(context).addedTo} ${playlistDetails[index].playlist}',
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddToPlaylist {
  Box settingsBox = Hive.box('settings');
  List playlistNames = Hive.box('settings')
      .get('playlistNames', defaultValue: ['Favorite Songs']) as List;
  Map playlistDetails =
      Hive.box('settings').get('playlistDetails', defaultValue: {}) as Map;

  void addToPlaylist(BuildContext context, MediaItem? mediaItem) {
    showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return BottomGradientContainer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).createPlaylist),
                  leading: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: SizedBox.square(
                      dimension: 50,
                      child: Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? null
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showTextInputDialog(
                      context: context,
                      keyboardType: TextInputType.name,
                      title: AppLocalizations.of(context).createNewPlaylist,
                      onSubmitted: (String value, BuildContext context) async {
                        final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');
                        value.replaceAll(avoid, '').replaceAll('  ', ' ');
                        if (value.trim() == '') {
                          value = 'Playlist ${playlistNames.length}';
                        }
                        if (playlistNames.contains(value) ||
                            await Hive.boxExists(value)) {
                          value = '$value (1)';
                        }
                        playlistNames.add(value);
                        settingsBox.put('playlistNames', playlistNames);

                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                if (playlistNames.isEmpty)
                  const SizedBox()
                else
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: playlistNames.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: playlistDetails[playlistNames[index]] ==
                                    null ||
                                playlistDetails[playlistNames[index]]
                                        ['imagesList'] ==
                                    null
                            ? Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox.square(
                                  dimension: 50,
                                  child: Image(
                                    image: AssetImage(
                                      Utils.assets('images/album.png'),
                                    ),
                                  ),
                                ),
                              )
                            : Collage(
                                imageList: playlistDetails[playlistNames[index]]
                                    ['imagesList'] as List,
                                showGrid: true,
                                placeholderImage:
                                    Utils.assets('images/cover.jpg'),
                              ),
                        title: Text(
                          '${playlistDetails.containsKey(playlistNames[index]) ? playlistDetails[playlistNames[index]]["name"] ?? playlistNames[index] : playlistNames[index]}',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          if (mediaItem != null) {
                            addItemToPlaylist(
                              playlistNames[index].toString(),
                              mediaItem,
                            );
                            ShowSnackBar().showSnackBar(
                              context,
                              '${AppLocalizations.of(context).addedTo} ${playlistDetails.containsKey(playlistNames[index]) ? playlistDetails[playlistNames[index]]["name"] ?? playlistNames[index] : playlistNames[index]}',
                            );
                          }
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
