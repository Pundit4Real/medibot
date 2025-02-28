import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ConversationEvent {
  final String message;

  SendMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}
