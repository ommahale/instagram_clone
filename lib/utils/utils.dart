import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? _image = await imagePicker.pickImage(source: source);
  if (_image != null) {
    return await _image.readAsBytes();
  }
  return null;
}
