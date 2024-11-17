class Grade {
  String? id;
  String sid;
  String grade;

  Grade({required this.sid, required this.grade, this.id});

  Map<String, dynamic> toMap() {
    return {
      'sid': sid,
      'grade': grade,
    };
  }

  Grade.fromMap(Map<String, dynamic> map) :
      sid = map['sid'],
      grade = map['grade'];
}