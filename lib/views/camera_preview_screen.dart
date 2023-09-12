import 'package:flutter/material.dart';
import 'package:fractoliotesting/dialogs/generic_dialog.dart';
import 'package:fractoliotesting/views/product_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraControllerQR extends StatefulWidget {
  const CameraControllerQR({super.key});

  @override
  State<CameraControllerQR> createState() => _CameraControllerQRState();
}

class _CameraControllerQRState extends State<CameraControllerQR> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
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
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: cameraController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final String? qrcode =
              barcodes.isNotEmpty ? barcodes[0].rawValue : null;
          debugPrint('Value of qr is: $qrcode');
          cameraController.stop();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ProductsDetail(productId: qrcode),
            ),
          );
        },
      ),
    );
  }
}
