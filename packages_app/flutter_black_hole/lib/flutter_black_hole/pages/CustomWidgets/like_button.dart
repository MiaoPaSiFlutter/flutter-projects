import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';

import 'package:logging/logging.dart';

import 'package:flutter_black_hole/flutter_black_hole/pages/CustomWidgets/custom_widgets_index.dart';
import 'package:flutter_black_hole/flutter_black_hole/pages/Helpers/helpers_index.dart';

class LikeButton extends StatefulWidget {
  final MediaItem? mediaItem;
  final double? size;
  final Map? data;
  final bool showSnack;
  const LikeButton({
    super.key,
    required this.mediaItem,
    this.size,
    this.data,
    this.showSnack = false,
  });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  bool liked = false;
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _curve;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _scale = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 50,
      ),
    ]).animate(_curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.mediaItem != null) {
        liked = checkPlaylist('Favorite Songs', widget.mediaItem!.id);
      } else {
        liked = checkPlaylist('Favorite Songs', widget.data!['id'].toString());
      }
    } catch (e) {
      Logger.root.severe('Error in likeButton: $e');
    }
    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        icon: Icon(
          liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: liked ? Colors.redAccent : Theme.of(context).iconTheme.color,
        ),
        iconSize: widget.size ?? 24.0,
        tooltip: liked
            ? AppLocalizations.of(context).unlike
            : AppLocalizations.of(context).like,
        onPressed: () async {
          liked
              ? removeLiked(
                  widget.mediaItem == null
                      ? widget.data!['id'].toString()
                      : widget.mediaItem!.id,
                )
              : widget.mediaItem == null
                  ? addMapToPlaylist('Favorite Songs', widget.data!)
                  : addItemToPlaylist('Favorite Songs', widget.mediaItem!);

          if (!liked) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          setState(() {
            liked = !liked;
          });
          if (widget.showSnack) {
            ShowSnackBar().showSnackBar(
              context,
              liked
                  ? AppLocalizations.of(context).addedToFav
                  : AppLocalizations.of(context).removedFromFav,
              action: SnackBarAction(
                textColor: Theme.of(context).colorScheme.secondary,
                label: AppLocalizations.of(context).undo,
                onPressed: () {
                  liked
                      ? removeLiked(
                          widget.mediaItem == null
                              ? widget.data!['id'].toString()
                              : widget.mediaItem!.id,
                        )
                      : widget.mediaItem == null
                          ? addMapToPlaylist('Favorite Songs', widget.data!)
                          : addItemToPlaylist(
                              'Favorite Songs',
                              widget.mediaItem!,
                            );

                  liked = !liked;
                  setState(() {});
                },
              ),
            );
          }
        },
      ),
    );
  }
}
