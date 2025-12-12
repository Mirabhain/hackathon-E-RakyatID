import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../theme/app_colors.dart';

class DigitalSignatureScreen extends StatefulWidget {
  const DigitalSignatureScreen({Key? key}) : super(key: key);

  @override
  State<DigitalSignatureScreen> createState() => _DigitalSignatureScreenState();
}

class _DigitalSignatureScreenState extends State<DigitalSignatureScreen> {
  final GlobalKey _signatureKey = GlobalKey();
  List<Offset> _points = <Offset>[];

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      _points = List.from(_points)..add(renderBox.globalToLocal(details.globalPosition));
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _points.add(Offset.zero);
    });
  }

  void _clearSignature() {
    setState(() {
      _points = [];
    });
  }

  Future<void> _saveSignature() async {
    if (_points.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please draw a signature first')),
      );
      return;
    }

    try {
      RenderRepaintBoundary boundary =
          _signatureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Signature Saved'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Your signature has been saved successfully.'),
              const SizedBox(height: 16),
              Image.memory(pngBytes, height: 150),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving signature: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Signature', style: AppTextStyles.h2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sign below using your finger or stylus',
              style: AppTextStyles.bodyMedium,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: RepaintBoundary(
                key: _signatureKey,
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: CustomPaint(
                    painter: SignaturePainter(_points),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clearSignature,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Clear',
                      style: const TextStyle(color: AppColors.primaryBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _saveSignature,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save Signature',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset> points;

  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.points != points;
}
