import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class LocalFileService {
  static final LocalFileService instance = LocalFileService._();
  LocalFileService._();

  Future<String> uploadFile(XFile file, String destination) async {
    final dir = await getApplicationDocumentsDirectory();
    final base = Directory('${dir.path}/uploads/$destination');
    if (!await base.exists()) await base.create(recursive: true);
    final target = File(
        '${base.path}/${DateTime.now().millisecondsSinceEpoch}-${file.name}');
    if (file.path.isNotEmpty) {
      await File(file.path).copy(target.path);
    } else {
      final bytes = await file.readAsBytes();
      await target.writeAsBytes(bytes);
    }
    return target.path;
  }
}
