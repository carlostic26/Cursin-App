import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class editcourse extends StatefulWidget {
  DocumentSnapshot docid;
  editcourse({required this.docid});

  @override
  _editcourseState createState() => _editcourseState();
}

class _editcourseState extends State<editcourse> {
  TextEditingController nameCourse = TextEditingController();
  TextEditingController entCourse = TextEditingController();
  TextEditingController descCourse = TextEditingController();
  TextEditingController urlCourse = TextEditingController();
  TextEditingController valCourse = TextEditingController();
  TextEditingController imgUrlCourse = TextEditingController();

  @override
  void initState() {
    nameCourse = TextEditingController(text: widget.docid.get('nameCourse'));
    entCourse = TextEditingController(text: widget.docid.get('entCourse'));
    descCourse = TextEditingController(text: widget.docid.get('descCourse'));
    urlCourse = TextEditingController(text: widget.docid.get('urlCourse'));
    valCourse = TextEditingController(text: widget.docid.get('valCourse'));
    imgUrlCourse =
        TextEditingController(text: widget.docid.get('imgUrlCourse'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'nameCourse': nameCourse.text,
                'entCourse': entCourse.text,
                'descCourse': descCourse.text,
                'urlCourse': urlCourse.text,
                'valCourse': valCourse.text,
                'imgUrlCourse': imgUrlCourse.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              });
            },
            child: Text("save"),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              });
            },
            child: Text("delete"),
          ),
        ],
      ),
      body: Container(
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
