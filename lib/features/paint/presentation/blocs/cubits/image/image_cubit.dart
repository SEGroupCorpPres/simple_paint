

import 'package:simple_paint/core/core.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageState());

  // Helper sinf yoki DI orqali ImagePicker'ni olish mumkin
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageSafely() async {
    try {
      File? pickedCompressedImage = await pickImageSafely();
      return pickedCompressedImage;
    } catch (e) {
      debugPrint('Rasm tanlashda xatolik: $e');
      return null;
    }
  }

  Future<void> pickPhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final File file = File(pickedFile.path);
        // Yangi tanlangan rasmni paint bg ga joylaymiz
        emit(state.copyWith(photo: file));
      }
    } catch (e) {
      // Xatolikni qayta ishlash (masalan, ruxsat berilmaganda)
      // Bu yerda foydalanuvchiga xabar ko'rsatuvchi event jo'natish mumkin
      print("Rasm tanlashda xatolik: $e");
    }
  }

  /// Rasmni ro'yxatdan indeks bo'yicha olib tashlash
  // void removePhoto(String name) {
  //   // paint bg dagi image ni o'chiramiz
  //
  //   emit(state.copyWith(photo: updatedPhotos));
  // }

  /// Rasmlarni serverga saqlash (hozircha simulyatsiya)
  Future<void> downloadPhoto() async {
    if (state.isLoading || state.photo == null) return;

    emit(state.copyWith(isLoading: true));

    try {
      // Simulyatsiya uchun 2 soniya kutamiz
      await Future.delayed(const Duration(seconds: 2));

      print('${state.photo!.path} ta rasm "saqlandi"');

      emit(state.copyWith(isLoading: false));
      // Muvaffaqiyatli saqlangandan so'ng, ehtimol, sahifani yopasiz yoki xabar ko'rsatasiz.
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // Xatolikni foydalanuvchiga ko'rsatish
      print("Saqlashda xatolik: $e");
    }
  }
}
