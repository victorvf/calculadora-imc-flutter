import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Resultado";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Entre com os dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double resultCalculate = weight / (height * height);
      _info = "Resultado: ${resultCalculate.toStringAsPrecision(4)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true, // ele é do appBar
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ], //widget
      ), //appbar
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // ocupar toda a largura na horizontal, nao modifica os widgets que tem o tamanho definido
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ), //textfield
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura!";
                  }
                },
              ), //textfield
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ), //button
                ), //container
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                child: Text(
                  _info,
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ), //text
              ),
            ], //widget
          ), //column
        ), //Form
      ), //scrowview
    ); //scaffold
  } //build
}
