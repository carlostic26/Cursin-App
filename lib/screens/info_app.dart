import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cursin/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/drawer_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'course_adding.dart';
import 'course_adding_by_users.dart';
import 'course_edit.dart';
import 'course_information.dart';
import 'login_screen.dart';

class infoApp extends StatefulWidget {
  const infoApp(BuildContext context, {Key? key}) : super(key: key);

  @override
  _infoAppState createState() => _infoAppState();
}

//Subname to playstore
//"Cursin: Cursos Gratis Certificables por organizaciones de alto valor.",
class _infoAppState extends State<infoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //no color backg cuz the backg is an image
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          "Cursin: Cursos Gratis Certificables",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imhback.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        //color: Colors.grey[800],
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            //IMG CABECERA OGO MAIN
            Container(
                height: 200,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Image.asset("assets/logo_cursin_main.png")),

            SizedBox(
              height: 50,
            ),

            //Info de la app
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              //decoration: BoxDecoration(border: Border.all()),

              child: RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text:
                            'Cursin App es una aplicación movil multiplataforma para sistemas operativos Android OS y iOS, que recopila diariamente cursos que cumplen con tres caracteristicas principales:\n\n1. Cursos completamente gratis.\n2.Cursos certificables\n3.Emitidos por instituciones de valor\n\nNuestra frase slogan es: "El aprendizaje online tiene que ser gratuito.\nCursin nace de la idea del Ing. Carlos Peñaranda cuando se dió cuenta que muchos amigos y compañeros se disponian de mejor forma a estudiar cuando veian promociones o lanzamientos gratuitos de varios cursos en internet. Por lo que decidió desarrollaar Cursin para recopilar de manera frecuente cada curso gratuito de valor y de alta calidad en internet.',
                        style: new TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //Redes
            Expanded(
              child: Container(
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
                          text: "",
                          style: new TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
