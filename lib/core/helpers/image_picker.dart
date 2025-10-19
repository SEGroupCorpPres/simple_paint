import 'package:simple_paint/core/core.dart';

class PickedCompressedImage {
  final Uint8List bytes;
  final File? file; // may be null on web
  final String mimeType;

  PickedCompressedImage({required this.bytes, required this.file, required this.mimeType});
}

final ImagePicker _picker = ImagePicker();

Future<PickedCompressedImage?> pickImageSafely({
  required ImageSource source,
  int quality = 85, // 0-100
  int minWidth = 800, // shrink width if larger
  int minHeight = 800, // shrink height if larger
  bool keepExif = true,
  int? rotate, // optional manual rotation degrees
}) async {
  if (kIsWeb) {
    // flutter_image_compress doesn't work on web. Suggest alternative library.
    throw UnsupportedError(
      'pickImageSafely() is not supported on web. Use client-side resizing before upload.',
    );
  }

  final XFile? picked = await _picker.pickImage(source: source);
  if (picked == null) return null;

  // Read raw bytes from picked file
  final Uint8List originalBytes = await picked.readAsBytes();

  // Compress using flutter_image_compress
  final Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
    originalBytes,
    quality: quality,
    minWidth: minWidth,
    minHeight: minHeight,
    rotate: rotate ?? 0,
    keepExif: keepExif,
    // format: CompressFormat.jpeg, // optional: choose based on input
  );

  if (compressedBytes == null) {
    // Fallback: return original bytes (or throw)
    return PickedCompressedImage(
      bytes: originalBytes,
      file: File(picked.path),
      mimeType: picked.mimeType ?? 'image/jpeg',
    );
  }

  // Optionally write compressed bytes to a temporary file so APIs that need Files can use it
  final tempDir = await getTemporaryDirectory();
  final ext = (picked.path.split('.').last.isNotEmpty) ? picked.path.split('.').last : 'jpg';
  final tempFile = await File(
    '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.$ext',
  ).writeAsBytes(compressedBytes, flush: true);

  return PickedCompressedImage(
    bytes: compressedBytes,
    file: tempFile,
    mimeType: picked.mimeType ?? 'image/jpeg',
  );
}
