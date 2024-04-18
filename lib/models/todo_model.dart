class TodoModel {
  String title;
  String ?id;
  String desc;
  int status;
  String ?img;
 var createdAt;
  var updatedAt;
  String? uid;

  TodoModel({
    this.uid,
    this.id,
    required this.title,
    required this.desc,
    required this.status,
     this.img,
    required this.createdAt,
    this.updatedAt,

  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'] ?? '',
      uid: json['uid'],
      desc: json['desc'] ?? '',
      status: json['status'] ?? '',
      img: json['img'] ?? '',
      createdAt: json['createdAt'] ,
      updatedAt: json['updatedAt'] ,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'status': status,
      'img': img ?? "",
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
