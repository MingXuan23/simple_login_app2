class Role{
  final int id;
  final String role;

  Role(this.id, this.role);

  factory Role.fromJson(Map<String,dynamic> json){
    return Role(json["id"]??0 ,json["role"]??"");
  }
}