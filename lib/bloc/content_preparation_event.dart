part of 'content_preparation_bloc.dart';

@immutable
sealed class ContentPreparationEvent {}

final class ContentPreparationStarted extends ContentPreparationEvent {

}

final class SetAge extends ContentPreparationEvent {
  final int picker ;
  SetAge(this.picker);
}