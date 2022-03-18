import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmr_task/features/profile/models/profile/profile.dart';
import 'package:mmr_task/features/profile/profile_cubit/profile_cubit.dart';

class ToggleEditButton extends StatelessWidget {
  const ToggleEditButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, Profile>(
      builder: (context, docState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              child: Text(
                docState.mode == OperationMode.view ? 'Edit' : 'Save',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                if (docState.mode != OperationMode.view) {
                  BlocProvider.of<ProfileCubit>(context, listen: false)
                      .saveProfile();
                } else {
                  BlocProvider.of<ProfileCubit>(context, listen: false)
                      .changeOpMode(OperationMode.edit);
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            if (docState.mode == OperationMode.edit)
              InkWell(
                onTap: () {
                  BlocProvider.of<ProfileCubit>(context, listen: false)
                      .changeOpMode(OperationMode.view);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 18,
                    color:  Colors.white,
                  ),
                ),
              )
            else
              const SizedBox(),
          ],
        );
      },
    );
  }
}
