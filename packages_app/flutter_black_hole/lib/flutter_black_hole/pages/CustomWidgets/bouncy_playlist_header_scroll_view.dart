import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_black_hole/flutter_black_hole.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';


class BouncyPlaylistHeaderScrollView extends StatelessWidget {
  final ScrollController scrollController;
  final SliverList sliverList;
  final bool shrinkWrap;
  final List<Widget>? actions;
  final String title;
  final String? subtitle;
  final String? secondarySubtitle;
  final String? imageUrl;
  final bool localImage;
  final String? placeholderImage;
  final Function? onPlayTap;
  final Function? onShuffleTap;

  BouncyPlaylistHeaderScrollView({
    super.key,
    required this.scrollController,
    this.shrinkWrap = false,
    required this.sliverList,
    required this.title,
    this.subtitle,
    this.secondarySubtitle,
    this.placeholderImage,
    this.localImage = false,
    this.imageUrl,
    this.actions,
    this.onPlayTap,
    this.onShuffleTap,
  });

  final ValueNotifier<bool> isTransparent = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final Widget image = imageUrl == null
        ? Image(
            fit: BoxFit.cover,
            image: AssetImage(
                placeholderImage ?? Utils.assets('images/cover.jpg')),
          )
        : localImage
            ? Image(
                image: FileImage(
                  File(
                    imageUrl!,
                  ),
                ),
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                fit: BoxFit.cover,
                errorWidget: (context, _, __) => Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      placeholderImage ?? Utils.assets('images/cover.jpg')),
                ),
                imageUrl: imageUrl!,
                placeholder: (context, url) => Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      placeholderImage ?? Utils.assets('images/cover.jpg')),
                ),
              );
    final bool rotated =
        MediaQuery.sizeOf(context).height < MediaQuery.sizeOf(context).width;
    final double expandedHeight = rotated
        ? MediaQuery.sizeOf(context).width * 0.35
        : MediaQuery.sizeOf(context).width * 0.6;
    final double screenWidth = rotated
        ? MediaQuery.sizeOf(context).width * 0.3
        : MediaQuery.sizeOf(context).width * 0.5;

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: const BouncingScrollPhysics(),
      slivers: [
        AnimatedBuilder(
          animation: scrollController,
          child: FlexibleSpaceBar(
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: image,
                        ),
                      ),
                    ),
                    SizedBox.square(
                      dimension: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 20.0,
                          top: 10.0,
                        ),
                        child: Align(
                          alignment: Alignment.lerp(
                            Alignment.topCenter,
                            Alignment.center,
                            0.5,
                          )!,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (subtitle != null && subtitle!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 3.0,
                                    ),
                                    child: Text(
                                      subtitle!,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .color,
                                      ),
                                    ),
                                  ),
                                if (secondarySubtitle != null &&
                                    secondarySubtitle!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 3.0,
                                    ),
                                    child: Text(
                                      secondarySubtitle!,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .color,
                                      ),
                                    ),
                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (onPlayTap != null)
                                      Expanded(
                                        flex: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            onPlayTap!.call();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              // color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5.0,
                                                  offset: Offset(0.0, 3.0),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: Theme.of(context)
                                                                .colorScheme
                                                                .secondary ==
                                                            Colors.white
                                                        ? Colors.black
                                                        : Colors.white,
                                                    size: 26.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    ).play,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      color: Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary ==
                                                              Colors.white
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(width: 15),
                                    if (onShuffleTap != null)
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            onShuffleTap!.call();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.shuffle_rounded,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          builder: (context, child) {
            if (scrollController.offset.roundToDouble() > expandedHeight - 80) {
              isTransparent.value = false;
            } else {
              isTransparent.value = true;
            }
            return SliverAppBar(
              elevation: 0,
              stretch: true,
              pinned: true,
              centerTitle: true,
              // floating: true,
              backgroundColor: isTransparent.value ? Colors.transparent : null,
              iconTheme: Theme.of(context).iconTheme,
              expandedHeight: expandedHeight,
              actions: actions,
              flexibleSpace: child,
            );
          },
        ),
        sliverList,
      ],
    );
  }
}
