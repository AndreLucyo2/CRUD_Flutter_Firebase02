import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//========================================================================================
// Estudo firebase:
//========================================================================================
//referencia : https://petercoding.com/firebase/2020/04/04/using-cloud-firestore-in-flutter/

class CrudFirebase {
  String idColection;

  static inicializeFirabase() async {
    //INICIANDO O FIREBASE:
    //ref: https://stackoverflow.com/questions/63492211/no-firebase-app-default-has-been-created-call-firebase-initializeapp-in
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  Future<void> addColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;
    //Cria a coleção
    firestoreInstance.collection("users").add({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      print('');
      print('========================================================');
      print("ADD - success! " + value.id);
      //pego o id da coleção:
      idColection = value.id;
    });
  }

  Future<void> deleteColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;
    //Cria a coleção
    firestoreInstance
        .collection("users")
        .doc('OLsJWMYkHOHZvjcoASya')
        .delete()
        .then((value) {
      print('');
      print('========================================================');
      print("Delete - success!");
    });
  }

  Future<void> updateColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    //id que ser quer alterar:
    final String idDocument = 'Yak9YbPO3cvpJz1MC8tg';

    firestoreInstance
        .collection("users")
        .doc(
          idDocument,
        )
        .update({
      "name": "Andre",
      "email": "ALSUPDATE@example.com",
      "age": 555,
      "address": {
        "street": "Av. Parigot",
        "city": "Toledo",
      },
    }).then((_) {
      print('');
      print('========================================================');
      print("UPDATE - success!");
    });
  }

  /*
    usamos o método set()para adicionar dados ao documento. 
    Se um documento já existe e você deseja atualizá-lo, 
    você pode usar o parâmetro nomeado opcional mergee defini-lo como true.
    Desta forma, os dados existentes no documento não serão sobrescritos.
  */
  Future<void> updateSETComMergeTrueColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    //id que ser quer alterar:
    final String idDocument = 'hdaTs7G4FnBMSkzMrKpC';

    firestoreInstance
        .collection("users")
        .doc(
          idDocument,
        )
        .set({
      "name": "Lucas",
      "genero": "Masculino",
      "altura": "1.55",
    }, SetOptions(merge: true)).then((_) {
      print('');
      print('========================================================');
      print("SET - MERGE - success!");
    });
  }

  Future<void> updateAddNovoCampoNaColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    //id que ser quer alterar:
    final String idDocument = '1Ot2lpFtcVM2Da4YRt5W';

    firestoreInstance
        .collection("users")
        .doc(
          idDocument,
        )
        .update({
      "name": "Andre",
      "email": "ALSUPDATE@example.com",
      "age": 555,
      "address": {
        "street": "Av. Parigot",
        "city": "Toledo",
        "CEP": "99150-000",
      },
      "genero": "Masculino",
    }).then((_) {
      print('');
      print('========================================================');
      print("UPDATE add novo campo - success!");
    });
  }

  Future<void> getAllColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;
    //Faz uma consulta:
    firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data());
        print(element.exists);
      });
      print('');
      print('========================================================');
      print("GET - success!");
    });
  }

  Future<void> getByIdColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    //id que ser quer alterar:
    final String idDocument = '1Ot2lpFtcVM2Da4YRt5W';

    //Faz uma consulta:
    firestoreInstance.collection("users").doc(idDocument).get().then((value) {
      //mostra ID:
      print(value.id);
      //Mostra todos os campos:
      print(value.data());
      //campo especifico:
      print("Cidade: " + value.data()["address"]["city"]);
      print("Nome: " + value.data()["name"]);
      print("GET BY ID DOC - success!");
    });
  }

  Future<void> getByIdWhereColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    //Faz uma consulta usando Where
    firestoreInstance
        .collection("users")
        .where("address.country", isEqualTo: "USA")
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  /*
  Ouça as atualizações em tempo real
  Para ouvir constantemente as alterações dentro de uma coleção, você pode usar o método snapshots():
  O snapshots()método retorna um Stream<QuerySnapshot>, 
  portanto, você pode chamar o método listen()que se inscreverá no fluxo 
  e continuará ouvindo as alterações no Cloud Firestore.
  */
  Future<void> getRealTimeColectionFirebaseTeste() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance
        .collection("users")
        .where("address.country", isEqualTo: "USA")
        .snapshots()
        .listen((result) {
      result.docs.forEach((result) {
        print(result.data());
      });
    });
  }
}
