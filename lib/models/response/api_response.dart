class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'ApiResponse{status: $status, data: $data, message: $message}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiResponse &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          data == other.data &&
          message == other.message;

  @override
  int get hashCode => status.hashCode ^ data.hashCode ^ message.hashCode;
}

enum Status { COMPLETED, ERROR }

