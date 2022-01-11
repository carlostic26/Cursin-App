import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class addcourse extends StatelessWidget {
  TextEditingController nameCourse = TextEditingController();
  TextEditingController entCourse = TextEditingController();
  TextEditingController certCourse = TextEditingController();
  TextEditingController descCourse = TextEditingController();
  TextEditingController urlCourse = TextEditingController();

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
              //If user left informartion in some box
              if (nameCourse.text == '' ||
                  entCourse.text == '' ||
                  descCourse.text == '' ||
                  urlCourse.text == '' ||
                  imgUrlCourse.text == '' ||
                  certCourse.text == '') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(children: <Widget>[
                        ListTile(
                            title: Text("No puedes dejar campos vacíos."),
                            leading: Icon(CupertinoIcons.exclamationmark),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                        //Boton OK dialogo corregir cajas vacias
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                              onPressed: () => Navigator.pop(context)),
                        ),
                      ]);
                    });
              } else {
                ref.add({
                  //Esto es solo lo que carga para transportar a otras pantallas en "ref"
                  'nameCourse': nameCourse.text,
                  'entCourse': entCourse.text,
                  'descCourse': descCourse.text,
                  'urlCourse': urlCourse.text,
                  'imgUrlCourse': imgUrlCourse.text,
                  'certCourse': certCourse.text
                }).whenComplete(() {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                });
              }
            },
            child: Icon(
              Icons.save,
              color: Colors.white,
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
                controller: certCourse,
                decoration: InputDecoration(
                  hintText: '¿Certificable?',
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
