

import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_app2/model/role.dart';

final url = "http://10.131.73.40:5000/api/User/";


//return datatype
//url
//after success, what to do /return
//exception handling
Future<List<Role>> getRoles() async{
  try{


    final get_user_url = "${url}getRoles" ;

    final request = await HttpClient().getUrl(Uri.parse(get_user_url));

    final response = await request.close();
    if(response.statusCode ==HttpStatus.ok){
      final result =await response.transform(utf8.decoder).join() ;
      final list = json.decode(result) as List;

      final rolelist = list.map((item) => Role.fromJson(item)).toList();
      return rolelist;
    }   
    else{
      return [];
    }
  }catch(ex){
      return [];
  }
}