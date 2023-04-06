// ignore: file_names
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({
    super.key,
  });

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool flashOn = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => controller!.flipCamera(),
            icon: const Icon(Icons.flip_camera_android)),
        IconButton(
            onPressed: () => setState(() {
                  controller!.toggleFlash();
                  flashOn = !flashOn;
                }),
            icon: flashOn
                ? const Icon(Icons.flash_on)
                : const Icon(Icons.flash_off))
      ]),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Taxi ID: ${result!.code!}') //${describeEnum(result!.format)}
                  : const Text('Scan a code'),
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: (result != null) ? () => {} : null,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(10)),
              child: const Text('Enter offer details'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
