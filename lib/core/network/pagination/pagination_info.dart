import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_info.freezed.dart';

@freezed
class PaginationInfo with _$PaginationInfo {
  @JsonKey(name: 'opensearch:startIndex')
  final int currentPage;
  final int totalPages;
  @JsonKey(name: 'opensearch:totalResults')
  final int totalItems;
  @JsonKey(name: 'opensearch:itemsPerPage')
  final int itemsPerPage;

  const PaginationInfo({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
  });

  bool get hasNextPage => currentPage < totalPages;
  bool get hasPreviousPage => currentPage > 1;

  // 편의 메서드들
  int get nextPage => hasNextPage ? currentPage + 1 : currentPage;
  int get previousPage => hasPreviousPage ? currentPage - 1 : currentPage;
  int get startIndex => (currentPage - 1) * itemsPerPage;
  int get endIndex => (startIndex + itemsPerPage).clamp(0, totalItems);
}
