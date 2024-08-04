abstract class RestResponse<T> {
  T? data;
  String? message;
}

class Success<T> extends RestResponse<T> {
  @override
  covariant T? data;

  @override
  String? message;

  Success(this.data);
}

class Error<T> extends RestResponse<T> {
  @override
  covariant var data;

  @override
  String? message;

  Error({this.data, required this.message});
}
