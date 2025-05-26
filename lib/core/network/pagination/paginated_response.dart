import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lyriverse/core/network/pagination/pagination_info.dart';

part 'paginated_response.freezed.dart';

@freezed
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  final List<T> items;
  final PaginationInfo pagination;

  const PaginatedResponse({
    required this.items,
    required this.pagination,
  });

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get length => items.length;
}
