import 'package:simple_paint/features/features.dart';
import 'package:simple_paint/features/paint/presentation/pages/paint_icon_btn.dart';

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

  void setStrokeColor(Color color) {
    controller.freeStyleColor = color;
  }

  void setSettingsMode(FreeStyleMode mode) {
    controller.freeStyleMode = mode;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    objectSettings = ObjectSettings();
    settings = PainterSettings(
      freeStyle: FreeStyleSettings(
        mode: FreeStyleMode.draw,
        color: selectedColor,
        strokeWidth: 3.r,
      ),
      object: objectSettings,
    );
    controller = PainterController(settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ScaffoldBuilderWidget(
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
            widget.isEdit ? AppConstants.paintPageTitleEdit.tr() : AppConstants.paintPageTitle.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            child: SvgPicture.asset(Assets.iconsCheck, width: AppSizes.defaultIconSize.sp),
            onTap: () {
              context.go(RouterNames.home);
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
                    PaintIconBtn(onPressed: () {}, svg: Assets.iconsDownloadMinimalistic),
                    PaintIconBtn(onPressed: () {}, svg: Assets.iconsBoldGalleryRound),
                    PaintIconBtn(
                      onPressed: () => setSettingsMode(FreeStyleMode.draw),
                      svg: Assets.iconsBoldPen,
                    ),
                    PaintIconBtn(
                      onPressed: () => setSettingsMode(FreeStyleMode.erase),
                      svg: Assets.iconsEraser,
                    ),
                    PaintIconBtn(
                      onPressed: () {
                        showColorPicker(context);
                      },
                      svg: Assets.iconsBoldPallete,
                    ),
                  ],
                ),
                FlutterPainter.builder(
                  controller: controller,
                  builder: (context, painter) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.r),
                        image: DecorationImage(image: NetworkImage('url')),
                      ),
                      width: double.infinity,
                      height: AppSizes.defaultImageEditableHeight,
                      child: painter,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void showColorPicker(BuildContext context) {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(pickerColor: pickerColor, onColorChanged: changeColor),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
          //
          // child: MultipleChoiceBlockPicker(
          //   pickerColors: currentColors,
          //   onColorsChanged: changeColors,
          // ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => selectedColor = pickerColor);
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
