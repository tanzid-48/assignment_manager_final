class Assignment {
  final int? id;
  final String title;
  final String subject;
  final String description;
  final String deadline;
  final String status;
  final String createdAt;

  Assignment({
    this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.deadline,
    required this.status,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'description': description,
      'deadline': deadline,
      'status': status,
      'created_at': createdAt,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'] as int?,
      title: map['title'] as String,
      subject: map['subject'] as String,
      description: map['description'] as String,
      deadline: map['deadline'] as String,
      status: map['status'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  Assignment copyWith({
    int? id,
    String? title,
    String? subject,
    String? description,
    String? deadline,
    String? status,
    String? createdAt,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Assignment(id: $id, title: $title, subject: $subject, status: $status)';
  }
}
