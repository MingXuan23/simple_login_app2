class User{
  final String username;
  final String password;

  User({required this.username,required this.password});

  static User nullUser(){
    return User(username: "",password: "");
  }

  //final user = User.nullUser();

  Map<String,dynamic> toJson(){
    return{
      "username":username,
      "password":password
    };
  }

  factory User.fromJson(Map<String,dynamic> json){
    return User(username: json["username"]??"", password: json["password"]??"");

    //json["username"] = "user1"
    //value return = "user1"

    //json["username"] = null / undefined
    //return ""
  }

}