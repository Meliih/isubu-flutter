import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// globals
import 'package:isubu_universite/Globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class Auth {
  
  //read data null check
  Future<bool> login(String username, String password, bool unforget) async {
    
    final event = await FirebaseDatabase.instance.ref('users/$username').once();

    if(event.snapshot.value == null)
      return false;
    else
    {
      final usernameInput = event.snapshot.child('username').value.toString();
      final passwordInput = event.snapshot.child('password').value.toString();
      final emailInput = event.snapshot.child('email').value.toString();
      
      

      if(usernameInput == username && passwordInput == base64Encode(utf8.encode(password))){
        
        if(unforget){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', username);
          prefs.setString('email', emailInput);
        }
        
        globals.username = username;
        globals.email = emailInput;
        return true;
      }
      else
        return false;
    }
      
  }

  Future<bool> signup(String username, String password, String email ) async {
    
    bool log = await login(username, password, false);
    // encode password
    password = base64Encode(utf8.encode(password));
    
    //decode password
    
      if(log == true)
        return false;
      else
      {
        DatabaseReference reference =
            FirebaseDatabase.instance.reference().child("users/$username");
        reference.set({
          'username': username,
          'password': password,
          'email': email
        });
        return true;
      }
    
    
      
  }

  

  
}

class User {
  String name;
  String password;
  String email;

  User(this.name, this.password, this.email);
}