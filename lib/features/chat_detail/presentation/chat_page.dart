import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/svg_icon.dart';
import 'package:chat/features/chat_detail/presentation/widgets/bottom_field.dart';
import 'package:chat/features/chat_detail/presentation/widgets/message_bubble.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatPage extends StatefulWidget {
  final ChatUser user;
  static String route = '/detail';
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FocusNode myFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    final state = Provider.of<ChatProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goFirstPosition(state.messages.length - 1);
    });
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () {
          return scrollToLast(state.messages.length - 1);
        });
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  void scrollToLast(int position) {
    itemScrollController.scrollTo(
      index: position,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void goFirstPosition(int position) {
    itemScrollController.jumpTo(index: position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true, //
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 3,
        surfaceTintColor: Colors.white,
        elevation: 0,
        shadowColor: AppColors.blackWithOpacity5,
        automaticallyImplyLeading: false,
        primary: true,
        titleSpacing: -5,
        titleTextStyle: AppTextStyles.s17w600clBlack,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        foregroundColor: AppColors.blue,
        title: Row(
          children: [
            SizedBox(height: 36, child: Image.asset(widget.user.imagePath)),
            SizedBox(width: 10),
            SizedBox(
              height: 36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.fullName,
                    style: AppTextStyles.s17w600clBlack,
                  ),
                  Text('Messenger', style: AppTextStyles.s13w500clBlack35),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgIcon(
              iconName: 'assets/icons/call.svg',
              height: 20,
              width: 20,
              iconColor: AppColors.blue,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: SvgIcon(
              iconName: 'assets/icons/video.svg',
              height: 20,
              width: 20,
              iconColor: AppColors.blue,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ChatProvider>(
          builder: (context, state, child) {
            if (state.shouldScroll) {
              scrollToLast(state.messages.length);
              state.markScrollDone();
            }

            return Column(
              children: [
                Expanded(
                  child: ScrollablePositionedList.separated(
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.messages.length,
                    separatorBuilder: (context, index) {
                      if ((state.messages[index + 1].isMe !=
                          state.messages[index].isMe)) {
                        return SizedBox(height: 12);
                      } else {
                        return SizedBox(height: 2);
                      }
                    },
                    itemBuilder: (context, index) {
                      final message = state.messages[index];

                      final previousMessage = index - 1 >= 0
                          ? state.messages[index - 1]
                          : null;

                      final nextMessage = index + 1 < state.messages.length
                          ? state.messages[index + 1]
                          : null;

                      return Row(
                        mainAxisAlignment: !message.isMe
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(width: !message.isMe ? 5 : 30),

                          if ((index == state.messages.length - 1 &&
                                  !message.isMe) ||
                              (!message.isMe &&
                                  state.messages[index + 1].isMe !=
                                      message.isMe))
                            Container(
                              margin: EdgeInsets.only(right: 6),
                              height: 28,
                              child: Image.asset(widget.user.imagePath),
                            )
                          else
                            SizedBox(width: 34),
                          MessageBubble(
                            message: message,
                            previousSame:
                                previousMessage != null &&
                                previousMessage.isMe == message.isMe,
                            nextSame:
                                nextMessage != null &&
                                nextMessage.isMe == message.isMe,
                          ),
                          if (message.isMe)
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child:
                                  message.type == 'text' || state.isSendedPhoto
                                  ? Icon(
                                      Icons.check_circle_outline,
                                      size: 16,
                                      color: AppColors.blue,
                                    )
                                  : SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              AppColors.blue,
                                            ),
                                      ),
                                    ),
                            ),
                          SizedBox(width: message.isMe ? 5 : 30),
                        ],
                      );
                    },
                  ),
                ),
                BottomField(
                  focusNode: myFocusNode,
                  textEditingController: textEditingController,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
