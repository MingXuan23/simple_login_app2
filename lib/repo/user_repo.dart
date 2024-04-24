import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_app2/model/user.dart';

final url = "http://10.131.73.214:5000/api/";
Future<List<User>> getUserList() async{
  final String userjson = await rootBundle.loadString('lib/assets/user.json');
  final  userdata = json.decode(userjson)['users'] as List;

  final users = userdata.map((json)=> User.fromJson(json)).toList();
  return users;
}

Future<int> loginViaApi(String username,String password) async{
  try{
    final login_url = "${url}User/login" ;
    final request = await HttpClient().postUrl(Uri.parse(login_url));

    //await HttpClient().getUrl(Uri.parse(login_url));
    request.headers.set('Content-Type', 'application/json;charset=UTF-8');

    final requestBody = json.encode({'Username': username ,'Password':password});
    request.write(requestBody);

    final response = await request.close();
    if(response.statusCode ==HttpStatus.ok){
      return int.parse(await response.transform(utf8.decoder).join());
    }
    else{
      return 0;
    }
  }catch(ex){
      return 0;
  }
}


Future<User> login(String username,String password) async{
  final userList = await getUserList();
  User user = userList.firstWhere((user) => user.username == username 
  && user.password == password, orElse: ()=> User.nullUser());

if(!isNullUser(user)){
  saveUserData(user);
}
  return user;
  
}

bool isNullUser(User user){
  return (user.username == "" && user.password == "");
}
//flutter pub add shared_preferences
Future<void> saveUserData(User user) async{
  final prefs = await SharedPreferences.getInstance(); 

  final userjson = json.encode(user.toJson());
  prefs.setString('user', userjson);
}

Future<int> checkSavedUserData() async{
  final prefs = await SharedPreferences.getInstance();

//for first time user
  final user_in_pref =prefs.getString('user');
  if(user_in_pref == null){
    return 0;
  }

  final userjson = json.decode(user_in_pref);
  final user =  User.fromJson(userjson);

  if(isNullUser(user)){
     return 0;
  }
  else{
    return 1;
  }
  
}