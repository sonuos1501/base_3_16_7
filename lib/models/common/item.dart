class Item {

  Item({this.id, this.ten});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
  }
  int? id;
  String? ten;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ten'] = ten;
    return data;
  }
}
