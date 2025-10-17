import 'package:simple_paint/core/core.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(RouterNames.paint, extra: {'id': index.toString(), 'isEdit': true});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: index != 10 ? 0 : 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/250?image=$index'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
