class APIResponse<T> {
  final bool success;
  final String message;
  final T? data;
  String? cid;

  APIResponse(
      {required this.success, required this.message, this.data, this.cid});
}
