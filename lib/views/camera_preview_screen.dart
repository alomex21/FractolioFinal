// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:fractoliotesting/services/services/firestore_storage.dart';
import 'product_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraControllerQR extends StatefulWidget {
  const CameraControllerQR({super.key});

  @override
  State<CameraControllerQR> createState() => _CameraControllerQRState();
}

class _CameraControllerQRState extends State<CameraControllerQR> {
  Barcode? barcode;
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    final scanwindow = Rect.fromCenter(
        center: MediaQuery.of(context).size.center(Offset.zero),
        width: 300,
        height: 300);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(
                      Icons.camera_front,
                      color: Colors.grey,
                    );
                  case CameraFacing.back:
                    return const Icon(
                      Icons.camera_rear,
                      color: Colors.grey,
                    );
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: [
            MobileScanner(
              fit: BoxFit.contain,
              scanWindow: scanwindow,
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final String? qrcode =
                    barcodes.isNotEmpty ? barcodes[0].rawValue : null;
                debugPrint('Value of qr is: $qrcode');
                cameraController.stop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProductsDetail(
                        productId: qrcode,
                        firebaseService: FirebaseService.instance),
                  ),
                );
              },
            ),
            CustomPaint(
              painter: ScannerOverlay(scanwindow),
            ),
          ],
        );
      }),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
