import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.index, required this.paint});

  final int index;
  final PaintModel paint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PaintBloc>().add(GetPaintEvent(id: paint.paintId));
        context.push(RouterNames.paint, extra: {'id': paint.paintId, 'isEdit': true});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: index != 10 ? 0 : 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          image: DecorationImage(image: NetworkImage(paint.imageUrl!), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
