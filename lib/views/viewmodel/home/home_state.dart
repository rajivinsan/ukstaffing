import 'package:sterling/models/shifts/shifts_model.dart';

import '../../../constants/enum.dart';

class HomeState {
  const HomeState(
      {this.status = Status.loading,
      this.offset = 0,
      this.errorMessage = '',
      this.data});

  HomeState copWith({
    Status? status,
    int? offset,
    List<dynamic>? data,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      offset: offset ?? this.offset,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          offset == other.offset &&
          data == other.data &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^ offset.hashCode ^ data.hashCode ^ errorMessage.hashCode;

  final Status status;
  final int offset;
  final String errorMessage;
  final List<dynamic>? data;
}
