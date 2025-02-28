import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/chat/screens/conversion.dart';
import '../../features/chat/managers/bloc.dart';
import '../../features/chat/endpoint/repository.dart';

class AppRoutes {
  static const String conversation = '/';

  static Route<dynamic> generateRoute(RouteSettings settings, ConversationRepository conversationRepository) {
    switch (settings.name) {
      case conversation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ConversationBloc(conversationRepository),
            child: ConversationScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'No route defined for this path',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
  }
}
