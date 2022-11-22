import 'dbHelper.dart';

class Prof {
  int? id;
  String? name;
  String? department;

  Prof(this.id, this.name, this.department);

  Prof.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    department = map["department"];
  }

  Map<String, dynamic> toJson() {
    return {
      // DBHelper.columnId: id,
      DBHelper.columnName: name,
      DBHelper.columnDepartment: department,
    };
  }
}
