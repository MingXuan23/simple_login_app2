import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_app2/model/user.dart';

final url = "http://10.131.73.40:5000/api/User/";
Future<List<User>> getUserList() async{
  final String userjson = await rootBundle.loadString('lib/assets/user.json');
  final  userdata = json.decode(userjson)['users'] as List;

  final users = userdata.map((json)=> User.fromJson(json)).toList();
  return users;
}

Future<String> loginViaApi(String username,String password) async{
  try{
    //final login_url = "${url}User/login" ;
    final login_url = "${url}login" ;

    final request = await HttpClient().postUrl(Uri.parse(login_url));

    //await HttpClient().getUrl(Uri.parse(login_url));
    request.headers.set('Content-Type', 'application/json;charset=UTF-8');

    final requestBody = json.encode({'Username': username ,'Password':password});
    request.write(requestBody);

    final response = await request.close();
    if(response.statusCode ==HttpStatus.ok){
      final token =await response.transform(utf8.decoder).join() ;
      saveUserData(token);

      return token;
    }   
    else{
      return "";
    }
  }catch(ex){
      return "";
  }
}

Future<dynamic> ManagerGetUsers() async{
  try{
    //final login_url = "${url}User/login" ;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if(token == null){
      throw Exception("invalid token");
    }

    final get_user_url = "${url}getUser" ;

    final request = await HttpClient().postUrl(Uri.parse(get_user_url));

    //await HttpClient().getUrl(Uri.parse(login_url));
    //request.headers.set('Content-Type', 'application/json;charset=UTF-8');
    request.headers.set('token', token);

    //final requestBody = json.encode({'Username': username ,'Password':password});
    //request.write(requestBody);

    final response = await request.close();
    if(response.statusCode ==HttpStatus.ok){
      final result =await response.transform(utf8.decoder).join() ;
      final list = json.decode(result);
      return list;
    }   
    else{
      return "";
    }
  }catch(ex){
      return "";
  }
}

// Future<User> login(String username,String password) async{
//   final userList = await getUserList();
//   User user = userList.firstWhere((user) => user.username == username 
//   && user.password == password, orElse: ()=> User.nullUser());

// if(!isNullUser(user)){
//   saveUserData(user);
// }
//   return user;
  
// }

// bool isNullUser(User user){
//   return (user.username == "" && user.password == "");
// }
//flutter pub add shared_preferences
Future<void> saveUserData(String token) async{
  final prefs = await SharedPreferences.getInstance(); 

  final tokenJson = token;
  prefs.setString('token', tokenJson);
}

Future<int> checkSavedUserData() async{
  final prefs = await SharedPreferences.getInstance();

//for first time user
  final token_in_pref =prefs.getString('token');
  if(token_in_pref == null){
    return 0;
  }

  final token = token_in_pref;

  if(token== ""){
     return 0;
  }
  else{
    return 1;
  }
  
}