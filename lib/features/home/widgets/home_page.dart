import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmr_task/features/auth/widgets/phone_login.dart';
import 'package:mmr_task/features/home/bloc/home_cubit.dart';
import 'package:mmr_task/features/home/bloc/video_cubit.dart';
import 'package:mmr_task/features/home/models/video.dart';
import 'package:mmr_task/features/home/widgets/video_page.dart';
import 'package:mmr_task/features/profile/profile_cubit/profile_cubit.dart';
import 'package:mmr_task/features/profile/widgets/profile_page.dart';
import 'package:mmr_task/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: Title(
            child: const Text('Home Page'),
            color: Colors.white,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfilePage()));
                },
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Profile')
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<ProfileCubit>(context).reset();
                  firebaseConfig!.auth.signOut();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PhoneLogin()));
                },
                child: Row(
                  children: const [
                    Icon(Icons.logout_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Logout')
                  ],
                ),
              ),
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, List<Video>>(
          builder: (context, videos) {
            if (videos.isEmpty) {
              return const SizedBox();
            }
            return ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return BlocProvider(
                    create: (context) => VideoCubit(videos[index]),
                    child: BlocBuilder<VideoCubit, Video>(
                      builder: (context, video) {
                        return ListTile(
                          leading: Text((index + 1).toString()),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return BlocProvider.value(
                                value: BlocProvider.of<VideoCubit>(context),
                                child: const VideoPage(),
                              );
                            }));
                          },
                          title: Text(video.name),
                          trailing: Icon(
                            Icons.circle,
                            color:
                                video.isCompleted ? Colors.green : Colors.grey,
                          ),
                        );
                      },
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
