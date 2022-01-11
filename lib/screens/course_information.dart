import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'course_edit.dart';
import 'home_screen.dart';

class infocourse extends StatefulWidget {
  DocumentSnapshot docid;
  infocourse({required this.docid});

  @override
  _infocourseState createState() => _infocourseState();
}

class _infocourseState extends State<infocourse> {
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

  Widget build(BuildContext context) {
    TextEditingController pass = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          nameCourse.text,
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          //vertical: 10,
          horizontal: 8,
        ),
        color: Colors.grey[800],
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            //IMG CABECERA CURSO
            Container(
              padding: EdgeInsets.symmetric(
                //vertical: 10,
                horizontal: 5,
              ),
              child: ListTile(
                leading: SizedBox(
                  height: 200.0,
                  width: 300.0,
                  child: Image.network(imgUrlCourse.text),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //NOMBRE CURSO
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              //decoration: BoxDecoration(border: Border.all()),

              child: RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Nombre: ',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent)),
                    new TextSpan(text: nameCourse.text),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),

            //ENTIDAD CURSO
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Por: ',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent)),
                    new TextSpan(text: entCourse.text),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //DESCRIPCION
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Detalles: ',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent)),
                    new TextSpan(text: descCourse.text),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //VALORACION DEL CURSO
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(border: Border.all()),
              child: RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Valoración: ',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent)),
                    new TextSpan(text: "${valCourse.text}/10"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //DESCRIPCION DEL CURSO
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 5.0),

                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    'Ir al curso',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: () {
                    launch(urlCourse.text);
                  },
                ),

                //decoration: BoxDecoration(border: Border.all()),

                /* //Texto en forma de link clikeable
                   child: InkWell(
                    child: Text(
                    'Ir al curso',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,

                      //color: Colors.yellowAccent,
                    ),
                  ),
                  onTap: () => launch(urlCourse.text),
                ),
                */
              ),
            )
          ],
        ),
      ),
    );
  }
}
