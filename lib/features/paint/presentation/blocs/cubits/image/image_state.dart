part of 'image_cubit.dart';

class ImageState extends Equatable {
  final File? photo;
  final bool isLoading;

  const ImageState({this.photo, this.isLoading = false});

  ImageState copyWith({File? photo, bool? isLoading}) {
    return ImageState(photo: photo ?? this.photo, isLoading: isLoading ?? this.isLoading);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [photo, isLoading];
}
