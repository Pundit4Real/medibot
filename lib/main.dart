import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/chat/managers/bloc.dart';
import 'features/chat/endpoint/repository.dart';
import 'core/routes/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  final conversationRepository = ConversationRepository(); // Create instance

  runApp(MyApp(conversationRepository: conversationRepository));
}

class MyApp extends StatelessWidget {
  final ConversationRepository conversationRepository;

  const MyApp({super.key, required this.conversationRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConversationBloc>(
          create: (context) => ConversationBloc(conversationRepository), // Pass repository
        ),
      ],
      child: MaterialApp(
        title: 'MediBot AI',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.conversation, // Set initial route
        onGenerateRoute: (settings) => AppRoutes.generateRoute(settings, conversationRepository), // Pass repo
      ),
    );
  }
}
