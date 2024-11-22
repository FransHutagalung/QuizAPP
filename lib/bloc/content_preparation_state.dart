part of 'content_preparation_bloc.dart';

@immutable
sealed class ContentPreparationState {}

final class ContentPreparationInitial extends ContentPreparationState {
  int step = 0;
}


final class AgePicker extends ContentPreparationState {
  int age = 1;
  AgePicker(this.age);
}
