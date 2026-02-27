import 'package:chat/core/main_scaffold.dart';
import 'package:chat/features/chat/presentation/chat_page.dart';
import 'package:chat/features/contacts/presentation/contact_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(path: '/chat', builder: (context, state) => const ChatPage()),
        GoRoute(
          path: '/contacts',
          builder: (context, state) => const ContactPage(),
        ),
      ],
    ),
  ],
);
