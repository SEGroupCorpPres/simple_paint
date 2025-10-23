part of 'network_cubit.dart';

enum NetworkStatus { initial, connected, disconnected }

class NetworkState extends Equatable {
  final NetworkStatus status;

  const NetworkState({this.status = NetworkStatus.initial});

  NetworkState copyWith({
    NetworkStatus? status,
  }) {
    return NetworkState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
