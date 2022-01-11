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
import 'info_app.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // get email to check login
  String email = "";
  //keep sesion loged in
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
    });
  }

  final Stream<QuerySnapshot>
      _usersStream = //Aqui va y busca en firestore esta colleccion para mostrarla
      FirebaseFirestore.instance.collection('cursos').snapshots();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    getEmail();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController passEdit = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[850],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* //para ir a add course directamene
          Navigator.pushReplacement(
           context, MaterialPageRoute(builder: (_) => addcourse())
          );
          */

          //Al presionar en el boton flotante primero muestra aviso de agregar cursos
          _showDialog(context);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Cursos Gratis con Certificado",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                                  //que puede ser reemplazada por la de INFO CURSO en completos
                                  infocourse(docid: snapshot.data!.docs[index]),
                        ),
                      ); //paso a la otra pantalla
                    },
                    onDoubleTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(children: <Widget>[
                              Container(
                                child: TextField(
                                  controller: passEdit,
                                  decoration: InputDecoration(
                                    hintText: 'Pass to edit',
                                  ),
                                ),
                              ),
                              //boton aceptar pass
                              Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'ok',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                                    onPressed: () => {
                                          if (passEdit.text == "6819")
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                                                          //que puede ser reemplazada por la de INFO CURSO en completos
                                                          editcourse(
                                                              docid: snapshot
                                                                  .data!
                                                                  .docs[index]),
                                                ),
                                              )
                                            }
                                        }),
                              ),
                            ]);
                          });
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors
                                    .grey[700], // Your desired background color
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.9),
                                      blurRadius: 6),
                                ]),
                            child: ListTile(
                              //ICONO O IMG DEL ITEM
                              //leading: const Icon(Icons.flight_land),

                              leading: SizedBox(
                                height: 100.0,
                                width: 80.0,
                                child: Image.network(snapshot.data!
                                    .docChanges[index].doc['imgUrlCourse']),
                              ),

                              //OPACIDAD DEL COLOR DEL LIST TILE
                              //tileColor: Colors.black.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),

                              //Aqui solo muestra en el ListView de Home el contenido de snapshot
                              //en este caso solo los cursos titulo y subtitulo

                              title: Text(
                                snapshot
                                    .data!.docChanges[index].doc['nameCourse'],
                                style: TextStyle(
                                  fontSize: 20,
                                  //COLOR DEL TEXTO TITULO
                                  color: Colors.blueAccent,
                                ),
                              ),

                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data!.docChanges[index]
                                        .doc['entCourse'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Certificable: ${snapshot.data!.docChanges[index].doc["certCourse"]}",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                ],
                              ),

                              contentPadding: EdgeInsets.symmetric(
                                vertical: 9,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }),
      drawer: _getDrawer(context),
    );
  }

  Widget _getDrawer(BuildContext context) {
    TextEditingController pass = TextEditingController();
    return Drawer(
      elevation: 0,
      child: Container(
        color: Colors.grey[850],
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                loggedInUser.name.toString(),
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                loggedInUser.email.toString(),
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: Image.asset('assets/icon/ic_launcher.png'),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blueGrey,
                  Colors.blueAccent,
                ]),
              ),
            ),

            /* //another drawer header if we need
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //LOGO IMG AVATAR STUDENT ONLY MULTISEX
                FlutterLogo(
                  size: 100,
                ),
                Text(
                  "Name",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          */

            ListTile(
              title: Text("Inicio", style: TextStyle(color: Colors.white)),
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              //at press, run the method
              onTap: () => showHome(context),
            ),
            ListTile(
              title: Text("Categorías", style: TextStyle(color: Colors.white)),
              leading: Icon(
                Icons.category,
                color: Colors.white,
              ),
              //at press, run the method
              onTap: () => showHome(context),
            ),
            ListTile(
              //Dialogo que los manda a la play store pidiendo reseña
              title: Text("Diplomados", style: TextStyle(color: Colors.white)),
              leading: Icon(
                Icons.school,
                color: Colors.white,
              ),
              //at press, run the method
              onTap: () => showHome(context),
            ),
            ListTile(
                //Dialogo que los manda a la play store pidiendo reseña
                title: Text("Añadir un curso",
                    style: TextStyle(color: Colors.white)),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                //at press, run the method
                onTap: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                                title: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "¿Quieres agregar un nuevo curso?",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Puedes añadir cursos gratuitos a la lista. \nEl equipo de Cursin las validará y publicará si se ajustan a los contenidos',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0),
                                      ),
                                    ]),
                                children: <Widget>[
                                  Container(
                                    height: 10.0,
                                    child: ListTile(
                                        title: Text(""),
                                        //leading: Icon(Icons.add),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SimpleDialog(children: <
                                                    Widget>[
                                                  Container(
                                                    child: TextField(
                                                      controller: pass,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'pass',
                                                      ),
                                                    ),
                                                  ),
                                                  //boton aceptar pass
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.0),
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .blueAccent,
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'ok',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                                                        onPressed: () => {
                                                              if (pass.text ==
                                                                  "6819")
                                                                {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (_) =>
                                                                              addcourse()))
                                                                }
                                                            }),
                                                  ),
                                                ]);
                                              });
                                        }),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Agregar un Curso',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                      //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                                      onPressed: () =>
                                          _showDialogAddCourseByUser(context),
                                    ),
                                  ),
                                ]);
                          }),
                    }),
            ListTile(
              //Nombre de la app, objetivo, parrafo de uso basico, creador, linkedin de creador, etc
              title:
                  Text("Info de la App", style: TextStyle(color: Colors.white)),
              leading: Icon(
                Icons.info,
                color: Colors.white,
              ),
              //at press, run the method
              onTap: () => {showinfo(context)},
            ),
            ListTile(
              //Dialogo que los manda a la play store pidiendo reseña
              title: Text("Califícanos", style: TextStyle(color: Colors.white)),
              leading: Icon(
                Icons.star,
                color: Colors.white,
              ),
              //at press, run the method
              onTap: () => showHome(context),
            ),
            ListTile(
              title:
                  Text("Cerrar sesión", style: TextStyle(color: Colors.white)),
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              //at press, run the method
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }

  //Dialogo para agregar cursos

  void _showDialog(BuildContext context) {
    TextEditingController pass = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¿Quieres agregar un nuevo curso?",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Puedes añadir cursos gratuitos a la lista. \nEl equipo de Cursin las validará y publicará si se ajustan a los contenidos',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ]),
              children: <Widget>[
                Container(
                  height: 10.0,
                  child: ListTile(
                      title: Text(""),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(children: <Widget>[
                                Container(
                                  child: TextField(
                                    controller: pass,
                                    decoration: InputDecoration(
                                      hintText: 'pass',
                                    ),
                                  ),
                                ),
                                //boton aceptar pass
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'ok',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                      //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                                      onPressed: () => {
                                            if (pass.text == "6819")
                                              {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            addcourse()))
                                              }
                                          }),
                                ),
                              ]);
                            });
                      }),
                ),
                Container(
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
                      'Agregar un Curso',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                    onPressed: () => _showDialogAddCourseByUser(context),
                  ),
                ),
              ]);
        });
  }

  void _showDialogAddCourseByUser(BuildContext context) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: <Widget>[
            ListTile(
                title: Text("Agregar nuevo curso"),
                leading: Icon(Icons.add),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => addcoursebyusers()));
                }),
          ]);
        });
  }

  void showHome(BuildContext context) {
    Navigator.pop(context);
  }

  void showinfo(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                //que puede ser reemplazada por la de INFO CURSO en completos
                infoApp(context),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    //Logout in 'keep user loged in'
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => loginScreen()));
  }
}
