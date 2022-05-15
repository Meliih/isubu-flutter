// firebase realtime database import
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
class DbHelper {
  void writeData(var trainer) {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("a");
    reference.set('asd');
  }
  //read data null check
   void readData() {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('a');
starCountRef.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    print(data);
});
  }
}