class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String goal;
  final String level;
  final String lookingFor;
  final String frequency;
  final String preferredTime;
  final String workingStyle;
  final String deadline;
  final String collaborationType;
  final List<String> likes;
  final List<String> matches;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.goal,
    this.level = '',
    this.lookingFor = '',
    this.frequency = '',
    this.preferredTime = '',
    this.workingStyle = '',
    this.deadline = '',
    this.collaborationType = '',
    this.likes = const [],
    this.matches = const [],
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      goal: map['goal'] ?? '',
      level: map['level'] ?? '',
      lookingFor: map['lookingFor'] ?? '',
      frequency: map['frequency'] ?? '',
      preferredTime: map['preferredTime'] ?? '',
      workingStyle: map['workingStyle'] ?? '',
      deadline: map['deadline'] ?? '',
      collaborationType: map['collaborationType'] ?? '',
      likes: List<String>.from(map['likes'] ?? []),
      matches: List<String>.from(map['matches'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'goal': goal,
      'level': level,
      'lookingFor': lookingFor,
      'frequency': frequency,
      'preferredTime': preferredTime,
      'workingStyle': workingStyle,
      'deadline': deadline,
      'collaborationType': collaborationType,
      'likes': likes,
      'matches': matches,
    };
  }

  UserProfile copyWith({
    String? uid,
    String? name,
    String? email,
    String? goal,
    String? level,
    String? lookingFor,
    String? frequency,
    String? preferredTime,
    String? workingStyle,
    String? deadline,
    String? collaborationType,
    List<String>? likes,
    List<String>? matches,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      goal: goal ?? this.goal,
      level: level ?? this.level,
      lookingFor: lookingFor ?? this.lookingFor,
      frequency: frequency ?? this.frequency,
      preferredTime: preferredTime ?? this.preferredTime,
      workingStyle: workingStyle ?? this.workingStyle,
      deadline: deadline ?? this.deadline,
      collaborationType: collaborationType ?? this.collaborationType,
      likes: likes ?? this.likes,
      matches: matches ?? this.matches,
    );
  }
}
