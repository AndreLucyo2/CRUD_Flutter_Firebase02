import 'package:cloud_firestore/cloud_firestore.dart';

/*
ref.: https://petercoding.com/firebase/2020/04/04/using-cloud-firestore-in-flutter/
 */

class ConsultasFirebase {
//Primeiro, vamos criar uma amostra de dados:
  Future<void> addAmostraDeDados() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("countries").add({
      "countryName": "australia",
      "size": 120000,
      "population": 20000,
      "characteristics": ["art", "diversity", "mountains"]
    });
    firestoreInstance.collection("countries").add({
      "countryName": "lebanon",
      "size": 1200,
      "population": 10400,
      "characteristics": ["history", "food", "parties"]
    });
    firestoreInstance.collection("countries").add({
      "countryName": "italy",
      "size": 140000,
      "population": 44000,
      "characteristics": ["music", "culture", "food"]
    });
  }

  Future<void> consulta1() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    var result = await firestoreInstance
        .collection("countries")
        .where("countryName", isEqualTo: "italy")
        .get();
    result.docs.forEach((res) {
      print('');
      print('========================================================');
      print(res.data());
    });
  }

  /*
  Outras consultas em um único campo que você pode realizar são:
  isLessThan
  isLessThanOrEqualTo
  isGreaterThanOrEqualTo
  */
  Future<void> consulta2() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    var result = await firestoreInstance
        .collection("countries")
        .where("population", isGreaterThan: 12000)
        .get();
    result.docs.forEach((res) {
      print('');
      print('========================================================');
      print(res.data());
    });
  }

  //Se quiser consultar um valor de matriz, você pode fazer o seguinte:
  Future<void> consulta3() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    var result = await firestoreInstance
        .collection("countries")
        .where("characteristics", arrayContains: "food")
        .get();
    result.docs.forEach((res) {
      print('');
      print('========================================================');
      print(res.data());
    });
  }

  //Isso retornará todos os documentos em que countryNameseja italyou lebanon.
  Future<void> consulta4WhereComOr() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    var result = await firestoreInstance
        .collection("countries")
        .where("countryName", whereIn: ["italy", "lebanon"]).get();
    result.docs.forEach((res) {
      print('');
      print('========================================================');
      print(res.data());
    });
  }

  //Isso recuperará os 3 primeiros countryNameem ordem crescente, resultado:
  //Agora, se você usar .orderBy("countryName", descending: true), isso irá recuperar os últimos 3 countryNameresultados:
  //Você também pode combinar where()com orderBy(), mas se estiver usando uma consulta de intervalo, ambos where()e orderBy()devem conter o mesmo campo.
  Future<void> consulta5UsandoLimit() async {
    //obtem uma instancia do firebase:
    final firestoreInstance = FirebaseFirestore.instance;

    var result = await firestoreInstance
        .collection("countries")
        .orderBy("countryName")
        .limit(3)
        .get();
    result.docs.forEach((res) {
      print('');
      print('========================================================');
      print(res.data());
    });
  }
}
