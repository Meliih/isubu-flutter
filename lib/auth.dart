import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class Auth {
  void writeData(var trainer) {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("a");
    reference.set('asd');
  }

  //read data null check
  Future<bool> login(String username, String password) async {
    
    final event = await FirebaseDatabase.instance.ref('users/$username').once();

    if(event.snapshot.value == null)
      return false;
    else
    {
      final usernameInput = event.snapshot.child('username').value.toString();
      final passwordInput = event.snapshot.child('password').value.toString();
      final emailInput = event.snapshot.child('email').value.toString();
      print(username);

      if((usernameInput == username || username == emailInput) && passwordInput == password){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', username);
        prefs.setString('email', emailInput);

        return true;
      }
      else
        return false;
    }
      
  }

  Future<bool> signup(String username, String password, String email) async {
    
    login(username, password).then((value){
      if(value == true)
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
    });
    return false;
      
  }

  

  
}

class User {
  String name;
  String password;
  String email;

  User(this.name, this.password, this.email);
}