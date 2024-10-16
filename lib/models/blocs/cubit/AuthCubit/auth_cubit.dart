import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../consts/Collections.dart';
import '../../../UserModel/User_Model.dart';
import '../../../data/Local/SharedKeys.dart';
import '../../../data/Local/SharedPerfrence.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);


  // controller for email
  TextEditingController emailController = TextEditingController();
  // controller for password
  TextEditingController passwordController = TextEditingController();
  // controller for confirm password
  TextEditingController confirmPasswordController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();


  UserModel? User;



  // controller for signIn
  TextEditingController signInEmailController = TextEditingController();
  // controller for signIn password
  TextEditingController signInPasswordController = TextEditingController();
  // form key for signIn
  final signInFormKey = GlobalKey<FormState>();


  // pick image from gallery
  XFile? image;
  final ImagePicker _picker = ImagePicker();

 // current user id
  String currentUid = "";


  // using firebase auth to signIn


  Future<void> signUpWithFire() async {
    emit(AuthLoading());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text).then((value) async {
      await addUserToFireStore(value);
    }).catchError((error) {
      emit(AuthError(error));
      print(error);
    });
  }

  Future<void> signInWithFire() async {
    emit(AuthLoading());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInEmailController.text, password: signInPasswordController.text).then((value) {
      storeDataFirebase(value);
      emit(AuthSuccess(value.user!));
    }).catchError((error) {
      emit(AuthError(error));
      print(error);
    });
  }


  // pick image from gallery
  Future<void> pickImageFromGallery({required uid , required email}) async {
    emit(ImagePickerLoading());
    var permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      try {
        XFile? pickedFile = await _picker.pickImage(
            source: ImageSource.gallery);
        if (pickedFile != null) {
          image = pickedFile;
          emit(ImagePickerSuccess(pickedFile));
        } else {
          emit(ImagePickerError('No image selected.'));
        }
      } catch (e) {
        emit(ImagePickerError('Failed to pick image: $e'));
      }
    } else if (permissionStatus.isDenied) {
      emit(ImagePickerError('Gallery permission is required to pick images'));
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
      emit(ImagePickerError(
          'Permission permanently denied. Please enable it in settings.'));
    }
  }

  Future<void> addUserToFireStore(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user == null) {
      throw Exception("User is null. Unable to add to Firestore.");
    }
    final uid = user.uid;
    currentUid = uid;
    await FirebaseFirestore.instance.collection(Collections.users).doc(uid).set({
      "UserName": emailController.text.split('@')[0],
      "Email": emailController.text,
      "uid": uid
    });
    print("User added to Firestore$currentUid" );

  }


  Future<void> uploadImage(
      {required XFile image , required String email,required uid})  async {
    print(image.name);
    print("The UUUUUUSSSSSEEERRRR Email IS $email");
    await FirebaseStorage.instance.ref()
        .child("ProfileImage/${email.toString()}/${image.name}")
        .putFile(File(image.path)).then((value){
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance.collection(Collections.users).doc(uid).update({
          "profileImage": value
        });
      });
    });
    emit(UploadImageSuccess(image.path));

  }


  void storeDataFirebase(UserCredential value) {
    debugPrint("Using StoreDataFirebase");
    LocalData.setData(key: SharedKey.uid, value: value.user?.uid);
    LocalData.setData(key: SharedKey.email, value: value.user?.email);
    LocalData.setData(key: SharedKey.isLogin, value: true);
  }

  // get user Info from Firebase
  Future<void>getUserInfoFire()async {
    emit(GetUserInfoLoading());
    FirebaseFirestore.instance.collection(Collections.users).snapshots().listen((value) {
      for (var doc in value.docs) {
        String docUid = doc.get('uid');
        if (LocalData.getData(key: SharedKey.uid) == docUid) {
          print(doc.id);
          print(LocalData.getData(key: SharedKey.uid));
          User = UserModel(
            email: doc.get('Email'),
            userName: doc.get("UserName"),
            profileImage: doc.get("profileImage"),

          );
          print(User?.email);
        }
      }
      emit(GetUserInfoSuccess());
    });
  }



  // signOut

  Future<void> signOut() async {
    emit(SignOutLoading());
    await FirebaseAuth.instance.signOut().then((value) {
      LocalData.clearData();
      emit(SignOutSuccess());
    }).catchError((error) {
      emit(AuthError(error));
      print(error);
    });
  }



  // clear controllers
  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }





}
