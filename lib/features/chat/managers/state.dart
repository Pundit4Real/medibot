import 'package:equatable/equatable.dart';

abstract class ConversationState extends Equatable {
  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Map<String, String>> messages;

  ConversationLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ConversationError extends ConversationState {
  final String error;

  ConversationError(this.error);

  @override
  List<Object> get props => [error];
}
