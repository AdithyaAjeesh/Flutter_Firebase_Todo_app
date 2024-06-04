class TodoModel {
  String? name;
  String? subName;
  bool? isDone;
  String? id;

  TodoModel({
    this.name,
    this.subName,
    this.isDone,
    this.id,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subName = json['subName'];
    isDone = json['is_done'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subName': subName,
      'is_done': isDone,
      'id': id,
    };
  }
}
