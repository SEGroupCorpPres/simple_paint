import 'package:simple_paint/core/core.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  NetworkCubit(this._connectivity) : super(const NetworkState()) {
    _init();
  }

  void _init() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    // The connection is considered disconnected if the list contains only ConnectivityResult.none
    if (result.contains(ConnectivityResult.none) && result.length == 1) {
      emit(state.copyWith(status: NetworkStatus.disconnected));
    } else {
      emit(state.copyWith(status: NetworkStatus.connected));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
