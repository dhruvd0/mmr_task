import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmr_task/features/home/models/video.dart';

class HomeCubit extends Cubit<List<Video>> {
  HomeCubit() : super([]) {
    getVideos();
  }

  void getVideos() {
    emit([
      const Video(
          youtubeLink: "https://www.youtube.com/watch?v=lytQi-slT5Y",
          isCompleted: false,
          name: "Flutter video"),
      const Video(
        youtubeLink: "https://www.youtube.com/watch?v=HD5gYnspYzk",
        isCompleted: false,
        name: "Adaptive vs Responsive",
      ),
       const Video(
        youtubeLink: "https://www.youtube.com/watch?v=fq4N0hgOWzU",
        isCompleted: false,
        name: "Introducing Flutter",
      )
    ]);
  }
}
