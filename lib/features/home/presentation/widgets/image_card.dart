import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.index, required this.paint});

  final int index;
  final PaintModel paint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Delete Paint"),
              content: Text("Are you sure you want to delete this paint?"),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    context.read<PaintBloc>().add(DeletePaintEvent(id: paint.paintId));
                    context.read<PaintBloc>().add(GetPaintsListEvent());
                    context.pop();
                  },
                  child: Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      onTap: () {
        context.read<PaintBloc>().add(GetPaintEvent(id: paint.paintId));
        context.push(RouterNames.paint);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: index != 10 ? 0 : 100),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Image.file(File(paint.imageUrl!)),
      ),
    );
  }
}
