import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'package:flutter_black_hole/flutter_black_hole/pages/CustomWidgets/custom_widgets_index.dart';
import 'package:flutter_black_hole/flutter_black_hole/pages/Helpers/helpers_index.dart';
import 'package:flutter_black_hole/flutter_black_hole/pages/Services/services_index.dart';

class DataSearch extends SearchDelegate {
  final List<SongModel> data;
  final String tempPath;

  DataSearch({required this.data, required this.tempPath}) : super();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isEmpty)
        IconButton(
          icon: const Icon(CupertinoIcons.search),
          tooltip: AppLocalizations.of(context).search,
          onPressed: () {},
        )
      else
        IconButton(
          onPressed: () {
            query = '';
          },
          tooltip: AppLocalizations.of(context).clear,
          icon: const Icon(
            Icons.clear_rounded,
          ),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      tooltip: AppLocalizations.of(context).back,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : [
            ...{
              ...data.where(
                (element) =>
                    element.title.toLowerCase().contains(query.toLowerCase()),
              ),
              ...data.where(
                (element) =>
                    element.artist!.toLowerCase().contains(query.toLowerCase()),
              ),
            },
          ];
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shrinkWrap: true,
      itemExtent: 70.0,
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        leading: OfflineAudioQuery.offlineArtworkWidget(
          id: suggestionList[index].id,
          type: ArtworkType.AUDIO,
          tempPath: tempPath,
          fileName: suggestionList[index].displayNameWOExt,
        ),
        title: Text(
          suggestionList[index].title.trim() != ''
              ? suggestionList[index].title
              : suggestionList[index].displayNameWOExt,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          suggestionList[index].artist! == '<unknown>'
              ? AppLocalizations.of(context).unknown
              : suggestionList[index].artist!,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () async {
          PlayerInvoke.init(
            songsList: suggestionList,
            index: index,
            isOffline: true,
            recommend: false,
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : [
            ...{
              ...data.where(
                (element) =>
                    element.title.toLowerCase().contains(query.toLowerCase()),
              ),
              ...data.where(
                (element) =>
                    element.artist!.toLowerCase().contains(query.toLowerCase()),
              ),
            },
          ];
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shrinkWrap: true,
      itemExtent: 70.0,
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        leading: OfflineAudioQuery.offlineArtworkWidget(
          id: suggestionList[index].id,
          type: ArtworkType.AUDIO,
          tempPath: tempPath,
          fileName: suggestionList[index].displayNameWOExt,
        ),
        title: Text(
          suggestionList[index].title.trim() != ''
              ? suggestionList[index].title
              : suggestionList[index].displayNameWOExt,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          suggestionList[index].artist! == '<unknown>'
              ? AppLocalizations.of(context).unknown
              : suggestionList[index].artist!,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () async {
          PlayerInvoke.init(
            songsList: suggestionList,
            index: index,
            isOffline: true,
            recommend: false,
          );
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Theme.of(context).colorScheme.secondary,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
      hintColor: Colors.white70,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      textTheme: theme.textTheme.copyWith(
        titleLarge:
            const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
      ),
      inputDecorationTheme:
          const InputDecorationTheme(focusedBorder: InputBorder.none),
    );
  }
}

class DownloadsSearch extends SearchDelegate {
  final bool isDowns;
  final List data;

  DownloadsSearch({required this.data, this.isDowns = false});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isEmpty)
        IconButton(
          icon: const Icon(CupertinoIcons.search),
          tooltip: AppLocalizations.of(context).search,
          onPressed: () {},
        )
      else
        IconButton(
          onPressed: () {
            query = '';
          },
          tooltip: AppLocalizations.of(context).clear,
          icon: const Icon(
            Icons.clear_rounded,
          ),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      tooltip: AppLocalizations.of(context).back,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : [
            ...{
              ...data.where(
                (element) => element['title']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              ),
              ...data.where(
                (element) => element['artist']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              ),
            },
          ];
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shrinkWrap: true,
      itemExtent: 70.0,
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        leading: imageCard(
          imageUrl: isDowns
              ? suggestionList[index]['image'].toString()
              : suggestionList[index]['image'].toString(),
          localImage: isDowns,
        ),
        title: Text(
          suggestionList[index]['title'].toString(),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          suggestionList[index]['artist'].toString(),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: isDowns
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DownloadButton(
                    data: suggestionList[index] as Map,
                    icon: 'download',
                  ),
                  SongTileTrailingMenu(
                    data: suggestionList[index] as Map,
                    isPlaylist: true,
                  ),
                ],
              ),
        onTap: () {
          PlayerInvoke.init(
            songsList: suggestionList,
            index: index,
            isOffline: isDowns,
            fromDownloads: isDowns,
            recommend: false,
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : [
            ...{
              ...data.where(
                (element) => element['title']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              ),
              ...data.where(
                (element) => element['artist']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              ),
            },
          ];
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shrinkWrap: true,
      itemExtent: 70.0,
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        leading: imageCard(
          imageUrl: isDowns
              ? suggestionList[index]['image'].toString()
              : suggestionList[index]['image'].toString(),
          localImage: isDowns,
        ),
        title: Text(
          suggestionList[index]['title'].toString(),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          suggestionList[index]['artist'].toString(),
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          PlayerInvoke.init(
            songsList: suggestionList,
            index: index,
            isOffline: isDowns,
            fromDownloads: isDowns,
            recommend: false,
          );
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Theme.of(context).colorScheme.secondary,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
      hintColor: Colors.white70,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      textTheme: theme.textTheme.copyWith(
        titleLarge:
            const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
      ),
      inputDecorationTheme:
          const InputDecorationTheme(focusedBorder: InputBorder.none),
    );
  }
}
