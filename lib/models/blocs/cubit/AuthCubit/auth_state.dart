part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

// Image picker
class ImagePickerLoading extends AuthState {}

class ImagePickerSuccess extends AuthState {
  final XFile image;

  ImagePickerSuccess(this.image);
}

class ImagePickerError extends AuthState {
  final String error;

  ImagePickerError(this.error);
}

// Image upload
class ImageUploadLoading extends AuthState {}

class UploadImageSuccess extends AuthState {
  final String imageUrl;

  UploadImageSuccess(this.imageUrl);
}

class ImageUploadError extends AuthState {
  final String error;

  ImageUploadError(this.error);
}


class GetUserInfoLoading extends AuthState {}

class GetUserInfoSuccess extends AuthState {
}

// sign out

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {}


