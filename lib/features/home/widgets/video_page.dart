import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmr_task/features/home/bloc/video_cubit.dart';
import 'package:mmr_task/features/home/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: Colors.white,
            child: BlocBuilder<VideoCubit, Video>(
              builder: (context, state) {
                return Text(state.name);
              },
            )),
        actions: [
          BlocBuilder<VideoCubit, Video>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color: state.isCompleted ? Colors.green : Colors.grey,
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<VideoCubit, Video>(
          builder: (context, state) {
            YoutubePlayerController _controller = YoutubePlayerController(
              initialVideoId:
                  YoutubePlayer.convertUrlToId(state.youtubeLink) ?? '',
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: true,
              ),
            );

            return YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onEnded: (videoData) {
                BlocProvider.of<VideoCubit>(context, listen: false)
                    .markVideoAsCompleted();
              },
            );
          },
        ),
      ),
    );
  }
}
