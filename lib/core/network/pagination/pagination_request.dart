import 'package:json_annotation/json_annotation.dart';

part 'pagination_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginationRequest {
  final int page;
  final int limit;

  const PaginationRequest({
    required this.page,
    required this.limit,
  });

  factory PaginationRequest.fromJson(Map<String, dynamic> json) =>
      _$PaginationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationRequestToJson(this);
}
