import 'package:chat/core/main_scaffold.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/features/chat_detail/presentation/chat_page.dart';
import 'package:chat/features/chat/presentation/chats_page.dart';
import 'package:chat/features/chat_detail/presentation/widgets/message_bubble.dart';
import 'package:chat/features/contacts/presentation/contact_page.dart';
import 'package:chat/features/discover/presentation/discover_page.dart';
import 'package:chat/features/profile/presentation/profile_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/chat',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },

      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/chat', builder: (context, state) => ChatsPage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/contacts',
              builder: (context, state) => ContactPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: ChatPage.route,
      builder: (context, state) => ChatPage(user: state.extra as ChatUser),
    ),

    GoRoute(
      path: ProfilePage.route,
      builder: (context, state) => ProfilePage(),
    ),
  ],
);
