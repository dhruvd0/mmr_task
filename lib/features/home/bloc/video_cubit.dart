import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmr_task/features/home/models/video.dart';

class VideoCubit extends Cubit<Video> {
  VideoCubit(Video initialState) : super(initialState);
  void markVideoAsCompleted() {
    emit(state.copyWith(isCompleted: true));
  }
}
