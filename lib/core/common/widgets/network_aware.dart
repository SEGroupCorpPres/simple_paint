import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class NetworkAware extends StatefulWidget {
  const NetworkAware({super.key, required this.child});

  final Widget child;

  @override
  State<NetworkAware> createState() => _NetworkAwareState();
}

class _NetworkAwareState extends State<NetworkAware> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        BlocBuilder<NetworkCubit, NetworkState>(
          builder: (context, state) {
            if (state.status == NetworkStatus.disconnected) {
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: state.status == NetworkStatus.connected ? Colors.green : Colors.red,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            state.status == NetworkStatus.connected ? Icons.wifi : Icons.wifi_off,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.status == NetworkStatus.connected
                                  ? 'Internet qayta ulandi'
                                  : 'Internet mavjud emas',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white, size: 20),
                            onPressed: () => context.read<NetworkCubit>(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
