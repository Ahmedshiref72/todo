import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeWidget extends StatelessWidget {
  final String taskId;

  QrCodeWidget({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrettyQr(
        data: taskId,
        size: 200,
        roundEdges: true,
        errorCorrectLevel: QrErrorCorrectLevel.Q, // Optional: Error correction level
      ),
    );
  }
}
