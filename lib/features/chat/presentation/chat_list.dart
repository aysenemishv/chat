import 'package:chat/const/app_colors.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/svg_icon.dart';
import 'package:chat/features/chat/widgets/chat_tile.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final Animatable<Offset> _slideTween = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeInOut));

  void insertItem(int index) {
    _listKey.currentState?.insertItem(index);
  }

  void removeItem(int index, ChatUser user) {
    final state = Provider.of<ChatProvider>(context, listen: false);

    state.removeChatUser(user.id);

    _listKey.currentState?.removeItem(index, (context, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(_slideTween),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ChatTile(chatUser: user),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ChatProvider>(context, listen: false);

    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      initialItemCount: state.users.length,
      itemBuilder: (context, index, animation) {
        final user = state.users[index];

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(_slideTween),
            child: Slidable(
              key: ValueKey(user.id),
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  CustomSlidableActionItem(
                    onPressed: (context) {
                      removeItem(index, user);
                    },
                    iconName: 'delete',
                  ),
                  CustomSlidableActionItem(
                    onPressed: (context) {
                      removeItem(index, user);
                    },
                    iconName: 'call',
                  ),
                  CustomSlidableActionItem(
                    onPressed: (context) {
                      removeItem(index, user);
                    },
                    iconName: 'delete',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  CustomSlidableActionItem(
                    onPressed: (context) {
                      removeItem(index, user);
                    },
                    iconName: 'menu',
                  ),
                  CustomSlidableActionItem(
                    onPressed: (context) {
                      removeItem(index, user);
                    },
                    iconName: 'notification',
                  ),
                  CustomSlidableActionItem(
                    onPressed: (context) {
                      removeItem(index, user);
                    },
                    iconName: 'delete',
                  ),
                ],
              ),
              child: ChatTile(chatUser: user),
            ),
          ),
        );
      },
    );
  }
}

class CustomSlidableActionItem extends StatefulWidget {
  final Function(BuildContext)? onPressed;
  final String iconName;
  const CustomSlidableActionItem({
    super.key,
    required this.onPressed,
    required this.iconName,
  });

  @override
  State<CustomSlidableActionItem> createState() =>
      _CustomSlidableActionItemState();
}

class _CustomSlidableActionItemState extends State<CustomSlidableActionItem> {
  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      onPressed: widget.onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.blackWithOpacity5,
        ),
        child: SvgIcon(
          iconName: 'assets/icons/${widget.iconName}.svg',
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
