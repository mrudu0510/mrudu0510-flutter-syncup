class MatchModel {
  final String id;
  final String user1Id;
  final String user2Id;
  final DateTime matchedAt;
  final String status;

  MatchModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.matchedAt,
    this.status = 'active',
  });

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'] ?? '',
      user1Id: map['user1Id'] ?? '',
      user2Id: map['user2Id'] ?? '',
      matchedAt: map['matchedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['matchedAt'])
          : DateTime.now(),
      status: map['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user1Id': user1Id,
      'user2Id': user2Id,
      'matchedAt': matchedAt.millisecondsSinceEpoch,
      'status': status,
    };
  }
}
