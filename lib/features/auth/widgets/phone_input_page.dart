import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmr_task/features/auth/widgets/otp_page.dart';
import 'package:mmr_task/config/theme/theme.dart';
import 'package:mmr_task/features/auth/bloc/auth_bloc/auth_bloc.dart';

import 'package:mmr_task/utils/widgets/buttons/curved_mono_button.dart';
import 'package:mmr_task/utils/widgets/decors/text_input_decoration.dart';

class PhoneNumberPage extends StatelessWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Enter Phone',
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
          child: TextField(
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              BlocProvider.of<AuthCubit>(context, listen: false)
                  .changePhoneNumber(value);
            },
            decoration: TextInputDecorations.defaultTextInputDecoration(
              Theme.of(context).textTheme.caption!,
              'XXXXXXXXXX',
            ).copyWith(
              prefix: const Text(
                '  +91  ',
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        RectMonoButton(
          text: 'Generate OTP',
          onTap: () {
            final auth = BlocProvider.of<AuthCubit>(context);
            if (auth.validatePhoneNumber()) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const OtpPage()));
              auth.generateOTP();
            }
          },
        )
      ],
    );
  }
}
