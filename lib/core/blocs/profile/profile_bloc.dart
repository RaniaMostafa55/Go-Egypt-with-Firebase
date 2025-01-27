import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_egypt_with_firebase/core/helpers/shared_pref_helper.dart';
import 'package:go_egypt_with_firebase/features/auth/user-profile.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  var avatarPath = "assets/images/boy_avatar.jpeg";

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final name = await SharedPrefHelper.getString("name") ?? "";
        final phone = await SharedPrefHelper.getString("phone") ?? "";
        final email = await SharedPrefHelper.getString("email") ?? "";
        final password = await SharedPrefHelper.getString("pass") ?? "";

        if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
          final user = UserProfile(
            name: name,
            email: email,
            password: password,
            phone: phone,
          );
          emit(ProfileLoaded(user));
        } else {
          emit(ProfileInitial());
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profileUpdate = event.profileData;

        await SharedPrefHelper.setData("name", profileUpdate.name);
        await SharedPrefHelper.setData("pass", profileUpdate.password);
        await SharedPrefHelper.setData("email", profileUpdate.email);
        await SharedPrefHelper.setData("phone", profileUpdate.phone);

        emit(ProfileUpdated(profileUpdate));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateAvatar>((event, emit) async {
      emit(ProfileLoading());
      try {
        toggleAvatar();
        final name = await SharedPrefHelper.getString("name") ?? "";
        final phone = await SharedPrefHelper.getString("phone") ?? "";
        final email = await SharedPrefHelper.getString("email") ?? "";
        final password = await SharedPrefHelper.getString("pass") ?? "";

        final user = UserProfile(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );
        emit(ProfileUpdated(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }

  void toggleAvatar() {
    avatarPath = avatarPath == "assets/images/boy_avatar.jpeg"
        ? "assets/images/girl_avatar.jpeg"
        : "assets/images/boy_avatar.jpeg";
    SharedPrefHelper.setData('path', avatarPath);
  }
}
