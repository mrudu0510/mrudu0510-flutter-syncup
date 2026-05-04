/// Match model for SyncUp app
class MatchModel {
  final String id;
  final String userId1;
  final String userId2;
  final double compatibilityScore;
  final DateTime matchedDate;
  final bool isActive;
  final String status; // pending, accepted, rejected

  MatchModel({
    required this.id,
    required this.userId1,
    required this.userId2,
    required this.compatibilityScore,
    required this.matchedDate,
    required this.isActive,
    required this.status,
  });

  /// Convert MatchModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId1': userId1,
      'userId2': userId2,
      'compatibilityScore': compatibilityScore,
      'matchedDate': matchedDate.toIso8601String(),
      'isActive': isActive,
      'status': status,
    };
  }

  /// Create MatchModel from JSON
  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] ?? '',
      userId1: json['userId1'] ?? '',
      userId2: json['userId2'] ?? '',
      compatibilityScore: (json['compatibilityScore'] ?? 0).toDouble(),
      matchedDate: DateTime.parse(json['matchedDate'] ?? DateTime.now().toIso8601String()),
      isActive: json['isActive'] ?? false,
      status: json['status'] ?? 'pending',
    );
  }

  /// Create a copy of MatchModel with optional new values
  MatchModel copyWith({
    String? id,
    String? userId1,
    String? userId2,
    double? compatibilityScore,
    DateTime? matchedDate,
    bool? isActive,
    String? status,
  }) {
    return MatchModel(
      id: id ?? this.id,
      userId1: userId1 ?? this.userId1,
      userId2: userId2 ?? this.userId2,
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      matchedDate: matchedDate ?? this.matchedDate,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'MatchModel(id: $id, userId1: $userId1, userId2: $userId2, compatibilityScore: $compatibilityScore, status: $status)';
  }
}
