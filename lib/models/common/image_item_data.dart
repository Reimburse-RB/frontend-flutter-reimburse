import 'dart:io';
import 'dart:typed_data';

class ImageItemData {
  File file;
  Uint8List byestsImg;
  String base64Image;

  ImageItemData({
    required this.file,
    required this.base64Image,
    required this.byestsImg,
  });
}
