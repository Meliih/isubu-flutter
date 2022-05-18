// firebase realtime database import
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class DbHelper {
  void writeData(var trainer) {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("a");
    reference.set('asd');
  }

  //read data null check
  Future<List<String>> getFaculties() async {
    List<String> faculties = [];
    final event = await FirebaseDatabase.instance.ref('faculties/').once();

    final data = event.snapshot.children;
    // child name
    data.forEach((element) {
      String value = element.key.toString();
      // add to list
      faculties.add(value);
     
    });

    return faculties;
  }

  Future<List<String>> getDepartments(String faculty) async {
    List<String> departments = [];
    final event = await FirebaseDatabase.instance.ref('faculties/$faculty').once();

    final data = event.snapshot.children;
    // child name
    data.forEach((element) {
      String value = element.key.toString();
      // add to list
      departments.add(value);
      
    });

    return departments;
  }

  Future<List<Teacher>> getTeachers(String department) async {
    
    List<Teacher> teachers = [];
    final event = await FirebaseDatabase.instance.ref('faculties/$department/Hocalar').once();
    
    final data = event.snapshot.children;
    // child name
    data.forEach((element) {
      List<String> teacherinfo = [];
      String value = element.value.toString().replaceAll('{', '').replaceAll('}', '');
      value.split(',').forEach((element) {
        String info = element.split(':')[1];
        teacherinfo.add(info);
        
      });
      // add to list
      teachers.add(Teacher(teacherinfo[0], teacherinfo[1], teacherinfo[2]));
      
    });

    return teachers;
  }
}

class Teacher {
  late String name;
  late String email;
  late String phone;

  Teacher(this.phone, this.name, this.email);

  
}
