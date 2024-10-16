import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../consts/Colors.dart';
import '../../../models/blocs/cubit/AuthCubit/auth_cubit.dart';


class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = AuthCubit.get(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SizedBox(
          child: InkWell(
            onTap: () {

              authCubit.pickImageFromGallery(email:authCubit.signInEmailController.text , uid: authCubit.currentUid);

            },
            child: CircleAvatar(
              radius: 60,
              backgroundColor:  authCubit.image != null ? AppColors.green : AppColors.gery,
              child: authCubit.image == null
                  ? const Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              )
                  : ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                  File(authCubit.image!.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                                  ),
                                ),
            ),
          ),
        );
      },
    );
  }
}