import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFHelper {
  static Future<void> downloadAndSharePDF(String url) async {
    // 1. Get a local directory
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/shared_document.pdf";

    // 2. Download file
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception("Failed to download PDF");
    }

    // 3. Write to local file
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    // 4. Share using share_plus — correct API
    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile(filePath)],
        text: "Please check this Payment Receipt",
      ),
    );

    if (result.status == ShareResultStatus.success) {
      print("Shared successfully!");
    } else {
      print("Share canceled or failed: ${result.status}");
    }
  }
}
