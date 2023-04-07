// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/offerCarpool/screens/enter_details_page.dart';
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
  QRViewController? _controller;
  bool flashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    _controller!.pauseCamera();
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: const BackButton(
                color: buttonColor,
              ),
              actions: [
                IconButton(
                    onPressed: () => _controller!.flipCamera(),
                    icon: const Icon(
                      Icons.flip_camera_android_outlined,
                      color: buttonColor,
                    )),
                IconButton(
                    onPressed: () => setState(() {
                          _controller!.toggleFlash();
                          flashOn = !flashOn;
                        }),
                    icon: flashOn
                        ? const Icon(
                            Icons.flash_on,
                            color: buttonColor,
                          )
                        : const Icon(
                            Icons.flash_off,
                            color: buttonColor,
                          ))
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
                          'Taxi ID: ${result!.code!}',
                          selectionColor: registerTitleColor,
                        )
                      : const Text('Scan a code',
                          selectionColor: registerTitleColor),
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: (result != null)
                      ? () => {
                            _controller!.pauseCamera(),
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder:
                                        (BuildContext routeContextcontext) =>
                                            EnterDetailsPage(
                                                taxiID: result!.code!)))
                                .then((value) {
                              _controller!.resumeCamera();
                            })
                          }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(10),
                    backgroundColor: buttonColor,
                  ),
                  child: const Text('Enter offer details'),
                ),
              )
            ],
          ),
        ),
        onWillPop: () async {
          _controller?.dispose();
          return true;
        });
  }
}
