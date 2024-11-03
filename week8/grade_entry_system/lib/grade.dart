class Grade {
  int? id;
  String sid;
  String grade;

  Grade({required this.sid, required this.grade, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sid': sid,
      'grade': grade,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id'],
      sid: map['sid'],
      grade: map['grade'],
    );
  }
}