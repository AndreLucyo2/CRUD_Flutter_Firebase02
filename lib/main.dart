import 'package:crud_flutter_firebase_02/consultasFirebase.dart';
import 'package:crud_flutter_firebase_02/crudFirebase.dart';
import 'package:flutter/material.dart';

void main() {
  //Inicia forebase
  CrudFirebase.inicializeFirabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final CrudFirebase crudF = CrudFirebase();

  final ConsultasFirebase consultasF = ConsultasFirebase();

  String idColecao = '';

  void _incrementCounter() {
    setState(() {
      //ESTUDO CRUD FIREBASE
      //crudF.addColectionFirebaseTeste();
      idColecao = crudF.idColection;
      crudF.updateColectionFirebaseTeste();
      crudF.getAllColectionFirebaseTeste();
      crudF.updateAddNovoCampoNaColectionFirebaseTeste();
      crudF.updateSETComMergeTrueColectionFirebaseTeste();
      crudF.deleteColectionFirebaseTeste();
      crudF.getByIdColectionFirebaseTeste();

      //consultasF.addAmostraDeDados();
      consultasF.consulta1();
      consultasF.consulta2();
      consultasF.consulta3();
      consultasF.consulta4WhereComOr();
      consultasF.consulta5UsandoLimit();

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
