import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';
import '../endpoint/repository.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository _repository;

  ConversationBloc(this._repository) : super(ConversationInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ConversationState> emit) async {
    if (event.message.isEmpty) return;

    final currentState = state;
    List<Map<String, String>> chatHistory = [];

    if (currentState is ConversationLoaded) {
      chatHistory = List<Map<String, String>>.from(currentState.messages);
    }

    chatHistory.add({"sender": "user", "text": event.message});
    emit(ConversationLoaded(messages: chatHistory));

    try {
      final updatedChatHistory = await _repository.sendMessage(event.message, chatHistory);
      emit(ConversationLoaded(messages: updatedChatHistory));
    } catch (e) {
      emit(ConversationError("Failed to connect to the AI bot. Please try again later."));
    }
  }
}
