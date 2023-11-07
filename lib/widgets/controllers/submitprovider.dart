import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SubmitProvider extends ChangeNotifier {
  File? _imageFile;
  File? get imageFile => _imageFile;
  Future<String> uploadImage(String id, File? imageFile) async {
    if (imageFile == null) {
      return "";
    }

    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('ProductImage').child(id);
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot downloadUrl = (await uploadTask);
      notifyListeners();
      return await downloadUrl.ref.getDownloadURL();
    } catch (e) {
      print('error + $e');
      return "";
    }
  }

  Future<String> generateAndUploadQRCode(String content, String idref) async {
    try {
      // Generate the QR code
      final qrValidationResult = QrValidator.validate(
        data: content,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );

      if (qrValidationResult.status == QrValidationStatus.error) {
        throw Exception(qrValidationResult.error);
      }

      final qrCode = qrValidationResult.qrCode;

      // Convert to image
      final painter = QrPainter.withQr(
        qr: qrCode!,
        gapless: false,
        embeddedImageStyle: null,
        embeddedImage: null,
      );

      final picData = await painter.toImageData(2048);
      if (picData == null) {
        throw Exception('Unable to convert QR code to image data.');
      }

      final bytes = picData.buffer.asUint8List();

      // Save the QR code image as a file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/$idref.png').create();
      await file.writeAsBytes(bytes);

      // Upload to Firebase Storage
      final storageRef =
          FirebaseStorage.instance.ref().child('qr_images/$idref.png');
      await storageRef.putFile(file);

      // Get the download URL
      final qrImageURL = await storageRef.getDownloadURL();

      // Delete the temporary file
      await file.delete();
      notifyListeners();
      return qrImageURL;
    } catch (e) {
      // Handle exceptions
      //print(e);
      rethrow;
    }
  }
}
