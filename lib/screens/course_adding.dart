import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class addcourse extends StatelessWidget {
  TextEditingController nameCourse = TextEditingController();
  TextEditingController entCourse = TextEditingController();
  TextEditingController descCourse = TextEditingController();
  TextEditingController urlCourse = TextEditingController();
  TextEditingController valCourse = TextEditingController();
  TextEditingController imgUrlCourse = TextEditingController();

  //crea una nueva coleccion el firestore database llamada cursos, igual que como se hizo con usuarios
  CollectionReference ref = FirebaseFirestore.instance.collection('cursos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                //Esto es solo lo que carga para transportar a otras pantallas en "ref"
                'nameCourse': nameCourse.text,
                'entCourse': entCourse.text,
                'descCourse': descCourse.text,
                'urlCourse': urlCourse.text,
                'valCourse': valCourse.text,
                'imgUrlCourse': imgUrlCourse.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              });
            },
            child: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        //padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: nameCourse,
                decoration: InputDecoration(
                  hintText: 'Nombre de curso',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: entCourse,
                decoration: InputDecoration(
                  hintText: 'Entidad del curso',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: urlCourse,
                decoration: InputDecoration(
                  hintText: 'Url del curso',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: imgUrlCourse,
                decoration: InputDecoration(
                  hintText: 'Url imagen del curso',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: valCourse,
                decoration: InputDecoration(
                  hintText: 'Valoración del curso 1-10',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                //decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: descCourse,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Descripcion del curso',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
