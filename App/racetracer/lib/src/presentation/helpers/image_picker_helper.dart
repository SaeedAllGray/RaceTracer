import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }
}
