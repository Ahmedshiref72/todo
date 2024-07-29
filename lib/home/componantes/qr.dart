import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:todo/shared/utils/navigation.dart';
import 'package:todo/shared/global/app_colors.dart';
import 'package:todo/shared/utils/app_routes.dart';
import 'package:todo/shared/utils/app_strings.dart';
import '../presentation/controller/one_task_controller/one_task_cubit.dart';
import '../presentation/screens/one_task_screen.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  List<CameraDescription>? cameras;
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    // Initialize cameras
    availableCameras().then((availableCams) {
      setState(() {
        cameras = availableCams;
        cameraController = CameraController(cameras![0], ResolutionPreset.high);
        cameraController!.initialize().then((_) {
          if (!mounted) return;
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.qrScanner),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(AppStrings.scanQRCode),
            ),
          ),
          if (cameraController != null && cameraController!.value.isInitialized)
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: _takePhoto,
                  child: Text(AppStrings.takePhoto),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final scannedCode = scanData.code;
      if (scannedCode != null) {
        controller.pauseCamera();
        _reloadTask(scannedCode);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.invalidQRCode)),
        );
      }
    });
  }

  Future<void> _takePhoto() async {
    try {
      final image = await cameraController!.takePicture();
      final scannedCode = await _extractQRCodeFromImage(image.path);

      if (scannedCode != null) {
        _reloadTask(scannedCode);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.noQRCodeFound)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppStrings.errorTakingPhoto} $e')),
      );
    }
  }

  Future<String?> _extractQRCodeFromImage(String imagePath) async {
    return null;
  }

  void _reloadTask(String qrCode) {
    BlocProvider.of<TaskCubit>(context).getTaskById(qrCode);
    navigateTo(
      context: context,
      screenRoute: Routes.taskDetailScreen,
      arguments: qrCode,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    cameraController?.dispose();
    super.dispose();
  }
}
