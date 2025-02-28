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
  List<Map<String, String>> updatedMessages = [];

  if (currentState is ConversationLoaded) {
    updatedMessages = List<Map<String, String>>.from(currentState.messages)
      ..add({"sender": "user", "text": event.message});
  } else {
    updatedMessages = [{"sender": "user", "text": event.message}];
  }

  emit(ConversationLoaded(messages: updatedMessages));

  try {
    final botResponse = await _repository.sendMessage(event.message);
    updatedMessages = List<Map<String, String>>.from((state as ConversationLoaded).messages)
      ..add({"sender": "bot", "text": botResponse});
    emit(ConversationLoaded(messages: updatedMessages));
  } catch (e) {
    emit(ConversationError("Failed to connect to the AI bot. Please try again later."));
  }
}

}
