import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmr_task/features/profile/models/profile/profile.dart';
import 'package:mmr_task/features/profile/profile_cubit/profile_cubit.dart';
import 'package:mmr_task/utils/widgets/decors/container_decors.dart';
import 'package:mmr_task/utils/widgets/toggle_edit_button.dart';
import 'package:regexpattern/regexpattern.dart';

import 'package:mmr_task/config/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const ToggleEditButton(),
              ),
            ],
            title: Title(
              color: Colors.white,
              child: const Text('Profile Page'),
            )),
        resizeToAvoidBottomInset: true,
        backgroundColor: BackgroundColors.lightGrey,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, Profile>(
            builder: (context, state) {
              var profileImage = state.toMap()['profileImage'];
              return SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final _picker = ImagePicker();

                          final image = await _picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 20,
                          );
                          if (image != null) {
                            BlocProvider.of<ProfileCubit>(
                              context,
                              listen: false,
                            ).updateKey('profileImage', image);
                          }
                        },
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration:
                              ContainerDecors.whiteCurvedContainerDecoration()
                                  .copyWith(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Container(
                              child: profileImage is XFile
                                  ? Image.file(File(profileImage.path))
                                  : profileImage.toString().isUrl()
                                      ? CachedNetworkImage(
                                          imageUrl: profileImage,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Center(
                                                child: Text(
                                                    'Tap here to change profile image'),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Icon(
                                                Icons.image,
                                              ),
                                            ],
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ...['name', 'email', 'country'].map(
                        (key) {
                          var value = state.toMap()[key].toString();
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: GestureDetector(
                              onTap: () {
                                if (state.mode == OperationMode.view) {
                                  BlocProvider.of<ProfileCubit>(
                                    context,
                                    listen: false,
                                  ).changeOpMode(OperationMode.edit);
                                }
                              },
                              child: TextFormField(
                                key: ValueKey(key),
                                initialValue: value,
                                textAlign: TextAlign.center,
                                enabled: state.mode == OperationMode.edit,
                                decoration: InputDecoration(
                                    hintText: value.isEmpty ? key : value),
                                onChanged: (str) {
                                  BlocProvider.of<ProfileCubit>(
                                    context,
                                    listen: false,
                                  ).updateKey(key, str);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
