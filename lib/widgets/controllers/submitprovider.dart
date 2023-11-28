import 'dart:io';
import 'dart:ui';
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
          FirebaseStorage.instance.ref().child('ProductImages/$id');
      final SettableMetadata metadata =
          SettableMetadata(contentType: 'image/jpeg');
      final UploadTask uploadTask = storageRef.putFile(imageFile, metadata);
      final TaskSnapshot taskSnapshot = await uploadTask;

      notifyListeners();
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error: ${e}');
      return "";
    }
  }

  Future<String> generateAndUploadQRCode(String content, String idref) async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: content,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      if (qrValidationResult.status == QrValidationStatus.error) {
        throw Exception(qrValidationResult.error);
      }
      final QrCode qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        gapless: false,
        color: Colors.black,
        emptyColor: Colors.white,
      );
      final picData =
          await painter.toImageData(2048, format: ImageByteFormat.png);
      if (picData == null) {
        throw Exception('Unable to convert QR code to image data.');
      }
      final bytes = picData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/$idref.png').create();
      await file.writeAsBytes(bytes);

      final SettableMetadata metadata =
          SettableMetadata(contentType: 'image/png');
      final storageRef =
          FirebaseStorage.instance.ref().child('qr_images/$idref.png');
      await storageRef.putFile(file, metadata);
      final qrImageURL = await storageRef.getDownloadURL();

      await file.delete(); // Delete the temporary file

      notifyListeners();
      return qrImageURL;
    } catch (e) {
      print('Error: ${e}');
      rethrow; // Re-throw the exception to handle it further up the call stack
    }
  }
}
