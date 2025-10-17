import 'package:simple_paint/features/features.dart';

class AddEditPaintPage extends StatefulWidget {
  const AddEditPaintPage({super.key, required this.id, required this.isEdit});

  final String id;
  final bool isEdit;

  @override
  State<AddEditPaintPage> createState() => _AddEditPaintPageState();
}

class _AddEditPaintPageState extends State<AddEditPaintPage> {
  @override
  Widget build(BuildContext context) {
    log('paint');

    return Container();
  }
}
