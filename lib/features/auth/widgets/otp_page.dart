import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mmr_task/config/theme/theme.dart';
import 'package:mmr_task/features/home/widgets/home_page.dart';

import 'package:mmr_task/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:mmr_task/features/auth/bloc/auth_bloc/auth_state.dart';

import 'package:mmr_task/main.dart';
import 'package:mmr_task/utils/widgets/buttons/curved_mono_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                'Enter OTP',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: BackgroundColors.lightGrey,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PinFieldAutoFill(
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder:
                        PinListenColorBuilder(Colors.cyan, Colors.green),
                  ),
                  onCodeSubmitted: (str) async {},
                  onCodeChanged: (str) {
                    BlocProvider.of<AuthCubit>(context, listen: false)
                        .changeOTP(str ?? '');
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (firebaseConfig!.auth.currentUser != null) {
                    await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) =>
                                const HomePage())); 
                  }
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return state.isVerifying
                        ? const CircularProgressIndicator()
                        : RectMonoButton(
                            text: 'Submit OTP',
                            onTap: () async {
                              await BlocProvider.of<AuthCubit>(context,
                                      listen: false)
                                  .loginWithOTP();
                            },
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
