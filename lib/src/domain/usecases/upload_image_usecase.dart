

import 'package:edspert/src/domain/repositories/profile_repository.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageUsecase {
  final ProfileRepository repository;

  UploadImageUsecase(this.repository);

  Future <String?> call (XFile file){
    return repository.uploadImage(file);
  }
}