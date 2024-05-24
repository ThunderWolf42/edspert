import 'dart:typed_data';

import 'package:edspert/src/domain/repositories/profile_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future <bool> editProfile(){
    throw UnimplementedError();
  }

  @override
  Future<String?> uploadImage (XFile file) async{
    try {
      String fileExt = file.path.split('.').last;
      Reference ref = FirebaseStorage.instance
        .ref('files')
        .child('profile_pic')
        .child('img_${DateTime.now().millisecondsSinceEpoch}.$fileExt');

      Uint8List byte = await file.readAsBytes();

      ///upload operation
      await ref.putData(byte);

      ///Get Download URL
      String? downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Err uploadImage: $e');
      return null;
    }
  }
}