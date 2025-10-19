import 'package:simple_paint/core/common/common.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ScaffoldBuilderWidget(
        appBarChildren: [],
        bodyChildren: [Container(padding: const EdgeInsets.all(16), child: Text(error))],
      ),
    );
  }
}
