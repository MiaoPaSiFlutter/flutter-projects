import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

import '../helper/helper_index.dart';
import '../pages/mail_view/mail_view_page.dart';
import '../utils/utils_index.dart';
import '../models/models_index.dart';
import '../providers/providers_index.dart';
import 'profile_avatar.dart';

class MailPreviewCard extends StatelessWidget {
  const MailPreviewCard({
    Key? key,
    required this.id,
    required this.email,
    required this.onDelete,
    required this.onStar,
  }) : super(key: key);

  final int id;
  final Email email;
  final VoidCallback onDelete;
  final VoidCallback onStar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentEmailStarred = Provider.of<EmailStore>(
      context,
      listen: false,
    ).isEmailStarred(email);

    final colorScheme = theme.colorScheme;
    final mailPreview = _MailPreview(
      id: id,
      email: email,
      onStar: onStar,
      onDelete: onDelete,
    );
    final onStarredInbox = Provider.of<EmailStore>(
          context,
          listen: false,
        ).currentlySelectedInbox ==
        'Starred';

    // TODO: Add Container Transform transition from email list to email detail page (Motion)
    return _OpenContainerWrapper(
      id: id,
      email: email,
      closedChild: Dismissible(
        key: ObjectKey(email),
        dismissThresholds: const {
          DismissDirection.startToEnd: 0.8,
          DismissDirection.endToStart: 0.4,
        },
        onDismissed: (direction) {
          switch (direction) {
            case DismissDirection.endToStart:
              if (onStarredInbox) {
                onStar();
              }
              break;
            case DismissDirection.startToEnd:
              onDelete();
              break;
            default:
          }
        },
        background: _DismissibleContainer(
          icon: 'twotone_delete',
          backgroundColor: colorScheme.primary,
          iconColor: ReplyColors.blue50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsetsDirectional.only(start: 20),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            if (onStarredInbox) {
              return true;
            }
            onStar();
            return false;
          } else {
            return true;
          }
        },
        secondaryBackground: _DismissibleContainer(
          icon: 'twotone_star',
          backgroundColor: currentEmailStarred
              ? colorScheme.secondary
              : theme.scaffoldBackgroundColor,
          iconColor: currentEmailStarred
              ? colorScheme.onSecondary
              : colorScheme.onBackground,
          alignment: Alignment.centerRight,
          padding: const EdgeInsetsDirectional.only(end: 20),
        ),
        child: mailPreview,
      ),
    );
  }
}

// TODO: Add Container Transform transition from email list to email detail page (Motion)
class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.id,
    required this.email,
    required this.closedChild,
  });

  final int id;
  final Email email;
  final Widget closedChild;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return MailViewPage(id: id, email: email);
      },
      openColor: theme.cardColor,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      closedElevation: 0,
      closedColor: theme.cardColor,
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: () {
            Provider.of<EmailStore>(
              context,
              listen: false,
            ).currentlySelectedEmailId = id;
            openContainer();
          },
          child: closedChild,
        );
      },
    );
  }
}

class _DismissibleContainer extends StatelessWidget {
  const _DismissibleContainer({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.alignment,
    required this.padding,
  });

  final String icon;
  final Color backgroundColor;
  final Color iconColor;
  final Alignment alignment;
  final EdgeInsetsDirectional padding;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: alignment,
      color: backgroundColor,
      curve: standardEasing,
      duration: kThemeAnimationDuration,
      padding: padding,
      child: Material(
        color: Colors.transparent,
        child: ImageIcon(
          Image.asset(Utils.assets('images/$icon.png')).image,
          size: 36,
          color: iconColor,
        ),
      ),
    );
  }
}

class _MailPreview extends StatelessWidget {
  const _MailPreview({
    required this.id,
    required this.email,
    this.onStar,
    this.onDelete,
  });

  final int id;
  final Email email;
  final VoidCallback? onStar;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var emailStore = Provider.of<EmailStore>(
      context,
      listen: false,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${email.sender} - ${email.time}',
                            style: textTheme.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          Text(email.subject, style: textTheme.headlineSmall),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    _MailPreviewActionBar(
                      avatar: email.avatar,
                      isStarred: emailStore.isEmailStarred(email),
                      onStar: onStar,
                      onDelete: onDelete,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 20,
                  ),
                  child: Text(
                    email.message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textTheme.bodyMedium,
                  ),
                ),
                if (email.containsPictures) ...[
                  const Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        _PicturePreview(),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PicturePreview extends StatelessWidget {
  const _PicturePreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 4),
            child: Image.asset(
              Utils.assets('images/paris_${index + 1}.jpg'),
              gaplessPlayback: true,
            ),
          );
        },
      ),
    );
  }
}

class _MailPreviewActionBar extends StatelessWidget {
  const _MailPreviewActionBar({
    required this.avatar,
    required this.isStarred,
    this.onStar,
    this.onDelete,
  });

  final String avatar;
  final bool isStarred;
  final VoidCallback? onStar;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(avatar: avatar),
      ],
    );
  }
}
