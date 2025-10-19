import 'dart:ui' as ui;

import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/core/helpers/painter_image.dart';
import 'package:simple_paint/features/paint/paint.dart';

class AddEditPaintPage extends StatefulWidget {
  const AddEditPaintPage({super.key, required this.id, required this.isEdit});

  final String? id;
  final bool isEdit;

  @override
  State<AddEditPaintPage> createState() => _AddEditPaintPageState();
}

class _AddEditPaintPageState extends State<AddEditPaintPage> {
  late PainterSettings settings;
  late ObjectSettings objectSettings;
  late PainterController controller;
  late Color selectedColor = Colors.green;
  late Color pickerColor = Colors.green;
  late List<Color> colors = [];
  PaintBloc bloc = sl<PaintBloc>();
  late double strokeWidth = 10;
  late PaintModel paintModel;


  List<Color> sortedColors() {
    final hexedColors = AppColors.hexColors;
    for (var rawColors in hexedColors) {
      for (var colColor in rawColors) {
        colors.add(colColor);
      }
    }
    // Shade bo‘yicha tartiblash (luminosity – perceived brightness)
    // colors.sort((a, b) => _brightness(a).compareTo(_brightness(b)));
    return colors;
  }

  double _brightness(Color color) {
    // Inson ko‘zi uchun RGB komponentlarining ta’sir nisbati
    return 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
  }

  void setStrokeColor(Color color) {
    controller.freeStyleColor = color;
  }

  void setStrokeWidth(double width) {
    controller.freeStyleStrokeWidth = width;
  }

  void setSettingsMode(FreeStyleMode mode) {
    controller.freeStyleMode = mode;
  }

  void setBackground(File? file, String? imgUrl) async {
    // Obtains an image from network and creates a [ui.Image] object
    if (imgUrl != null) {
      controller.background = await PainterImage.fromNetwork(imgUrl);
    }
    if (file != null) {
      final ui.Image myImage = await decodeImageFromList(file!.readAsBytesSync());
      controller.background = myImage.backgroundDrawable;
    }
    // Sets the background to the image
  }

  Future<void> saveImage(BuildContext context, Size size) async {
    final File image = await PainterImage().renderAndSave(controller: controller, size: size);
    DateTime now = DateTime.now();
    PaintModel paint = PaintModel(
      paintId: DateTime.now().microsecondsSinceEpoch.toString(),
      created: Timestamp.fromDate(now),
      updated: Timestamp.fromDate(now),
    );
    bloc.add(AddPaintEvent(paint: paint, image: image));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortedColors();
    selectedColor = colors[0];
    objectSettings = ObjectSettings();
    settings = PainterSettings(
      freeStyle: FreeStyleSettings(
        mode: FreeStyleMode.draw,
        color: selectedColor,
        strokeWidth: 10.r,
      ),
      object: objectSettings,
    );
    controller = PainterController(settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: BlocConsumer<PaintBloc, PaintState>(
        listener: (context, state) {
          if (state is LoadingPaintState) {
            showDialog(
              fullscreenDialog: true,
              context: context,
              builder: (context) => Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          if (state is GetPaintState) {
            paintModel = state.paint;
            setBackground(null, paintModel.url);
          }
          if (state is ErrorPaintState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,
              title: const Text('Error'),
              description: Text(state.error),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
          if (state is CreatePaintState || state is UpdatePaintState || state is DeletePaintState) {
            toastification.show(
              context: context,
              style: ToastificationStyle.fillColored,

              title: const Text('Success'),
              description: const Text('Image saved successfully!'),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          return ScaffoldBuilderWidget(
            isHome: true,
            appBarChildren: [
              InkWell(
                child: SvgPicture.asset(
                  Assets.iconsSmallLeft,
                  fit: BoxFit.fitWidth,
                  width: AppSizes.defaultIconSize.sp,
                ),
                onTap: () {
                  context.pop();
                },
              ),
              Text(
                widget.isEdit
                    ? AppConstants.paintPageTitleEdit.tr()
                    : AppConstants.paintPageTitle.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              InkWell(
                child: SvgPicture.asset(Assets.iconsCheck, width: AppSizes.defaultIconSize.sp),
                onTap: () {
                  saveImage(context, size);
                },
              ),
            ],
            bodyChildren: [
              Padding(
                padding: EdgeInsets.all(AppSizes.defaultPaintScreenHorizontalPadding.r),
                child: Column(
                  spacing: 20.h,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 10.w,
                      children: [
                        // PaintIconBtn(
                        //   onPressed: () {
                        //     PainterImage().renderAndSave(controller: controller, size: size);
                        //   },
                        //   svg: Assets.iconsDownloadMinimalistic,
                        // ),
                        PaintIconBtn(
                          onPressed: () async {
                            PainterImage()
                                .renderAndSave(controller: controller, size: size)
                                .whenComplete(() {
                                  toastification.show(
                                    context: context,
                                    style: ToastificationStyle.fillColored,
                                    title: const Text('Success'),
                                    description: const Text('Image saved successfully!'),
                                    type: ToastificationType.success,
                                    autoCloseDuration: const Duration(seconds: 3),
                                  );
                                });
                          },
                          svg: Assets.iconsDownloadMinimalistic,
                        ),
                        PaintIconBtn(
                          onPressed: () => context.read<ImageCubit>().pickPhoto(),
                          svg: Assets.iconsBoldGalleryRound,
                        ),
                        PaintIconBtn(
                          onPressed: () {
                            setSettingsMode(FreeStyleMode.draw);
                            showSetStrokeWidthBottomSheet(context);
                          },
                          svg: Assets.iconsBoldPen,
                        ),
                        PaintIconBtn(
                          onPressed: () {
                            setSettingsMode(FreeStyleMode.erase);
                            showSetStrokeWidthBottomSheet(context);
                          },
                          svg: Assets.iconsEraser,
                        ),
                        // PaintIconBtn(
                        //   onPressed: () {
                        //     showColorPicker(context);
                        //   },
                        //   svg: Assets.iconsBoldPaintBrush,
                        // ),
                        PaintIconBtn(
                          onPressed: () {
                            showColorPicker(context);
                          },
                          svg: Assets.iconsBoldPallete,
                        ),
                      ],
                    ),
                    BlocConsumer<ImageCubit, ImageState>(
                      listener: (context, state) {
                        if (state.photo != null) {
                          setBackground(state.photo, null);
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: AppSizes.defaultImageEditableHeight.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius.r),
                          ),
                          child: FlutterPainter.builder(
                            controller: controller,
                            builder: (context, painter) {
                              return painter;
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    setStrokeColor(color);
    context.pop();
  }

  void showSetStrokeWidthBottomSheet(BuildContext context) {
    showDialog(context: context, builder: (context) => setStrokeWidthBottomSheet());
  }

  Widget setStrokeWidthBottomSheet() => SafeArea(
    child: StatefulBuilder(
      builder: (context, setState) => BottomSheet(
        onClosing: () {},
        builder: (context) => SizedBox(
          width: 300,
          height: 50,
          child: Row(
            children: [
              SizedBox(
                width: 255,
                child: Slider(
                  key: const Key('slider'),
                  value: strokeWidth,
                  // This allows the slider to jump between divisions.
                  // If null, the slide movement is continuous.
                  // divisions: 1,
                  // The maximum slider value
                  min: 1,
                  max: 20,
                  activeColor: CupertinoColors.systemPurple,
                  thumbColor: CupertinoColors.systemPurple,
                  // This is called when sliding is started.

                  // This is called when slider value is changed.
                  onChanged: (double value) {
                    setState(() {
                      strokeWidth = value;
                      // setStrokeWidth(value);
                    });
                  },
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: SvgPicture.asset(Assets.iconsCheck),
                onTap: () {
                  setStrokeWidth(strokeWidth);
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void showColorPicker(BuildContext context) {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: const Text('Pick a color!'), content: buildColorPicker(context)),
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: BlockPicker(
        pickerColor: pickerColor,
        availableColors: colors,
        layoutBuilder: (context, layoutColors, callback) => SizedBox(
          child: Wrap(
            children: List.generate(
              layoutColors.length,
              (index) => InkWell(child: callback(layoutColors[index])),
            ),
          ),
        ),
        itemBuilder: (color, value, change) => InkWell(
          onTap: change,
          child: Container(width: 24, height: 24, color: color),
        ),
        onColorChanged: changeColor,
      ),
    );
  }
}
