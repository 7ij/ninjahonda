import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

Future<ui.Image> loadImage(var filePath) async {
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(
    Uint8List.view((await rootBundle.load(filePath)).buffer),
    (ui.Image img) {
      return completer.complete(img);
    },
  );
  return completer.future;
}
