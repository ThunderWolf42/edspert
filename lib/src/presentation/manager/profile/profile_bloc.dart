import 'package:bloc/bloc.dart';
import 'package:edspert/src/domain/usecases/upload_image_usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UploadImageUsecase uploadImageUsecase;
  ProfileBloc(this.uploadImageUsecase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is UploadImageEvent){
        emit (UploadImageLoading());
        final uploadImage = await uploadImageUsecase(event.file);
        if (uploadImage != null){
          emit (UploadImageSuccess(uploadImage));
          return ;
        }

        emit (UploadImageError());
      }

    });
  }
}
