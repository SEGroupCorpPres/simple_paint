import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:simple_paint/core/core.dart';

class PainterImage {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      responseType: ResponseType.bytes,
    ),
  );
  Future<File> renderAndSave({required PainterController controller, required Size size}) async {
    try {
      logger.i('Rendering image...');
      final renderedImage = await controller.renderImage(size);
      final byteData = await renderedImage.toByteData(format: ImageByteFormat.png);

      if (byteData == null) {
        throw CacheException('Failed to convert rendered image to byte data.');
      }

      final pngBytes = byteData.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
      final file = File('${directory.path}/$fileName');
      
      await file.writeAsBytes(pngBytes);
      logger.i('Image successfully saved to file: ${file.path}');

      try {
        await ImageGallerySaverPlus.saveImage(pngBytes, name: fileName);
        logger.i('Image also saved to device gallery.');
      } catch (e) {
        logger.e('Could not save image to gallery: $e');
        // Continue without re-throwing as the file is already saved locally.
      }

      return file;
    } on AppException catch (e) {
      logger.e('A known application error occurred: ${e.message}');
      throw CacheException(e.message);
    } catch (e) {
      logger.e('An unexpected error occurred while saving the image: $e');
      throw CacheException('An unexpected error occurred while saving the image.');
    }
  }
  static Future<ImageBackgroundDrawable> fromNetwork(String imageUrl) async {
    try {
      debugPrint("📥 Rasm yuklanmoqda: $imageUrl");

      // Rasmni yuklab olish (raw bytes formatda)
      final response = await _dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode != 200 || response.data == null) {
        throw Exception("❌ Rasm yuklanmadi (status: ${response.statusCode})");
      }

      // Byte arraydan ui.Image yaratish
      final Uint8List bytes = Uint8List.fromList(response.data!);
      final Codec codec = await instantiateImageCodec(bytes);
      final FrameInfo frameInfo = await codec.getNextFrame();

      debugPrint("✅ Rasm muvaffaqiyatli decode qilindi");

      // FlutterPainter uchun drawable yaratish
      return ImageBackgroundDrawable(
        image: frameInfo.image,
      );
    } catch (e, s) {
      debugPrint("⚠️ Rasm yuklashda yoki decode qilishda xatolik: $e\n$s");
      rethrow;
    }
  }
}
