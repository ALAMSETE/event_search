// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({Key? key}) : super(key: key);

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {

  String? dropdownCategory;
  String? dropdownName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: ListView(
          children: [
            Wrap(
              runSpacing: 15,
              children: [
                textoCabecera("Elige la categoria sobre la que quiere realizar la consulta", MediaQuery.of(context).size.width),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width-10,
                    decoration: BoxDecoration(
                      color: Color(0x44000000),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.black,
                      hint: Text("Selecciona la categoría", style: TextStyle(color: Colors.white),),
                      isExpanded: true,
                      value: dropdownCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.yellowAccent.shade700,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownCategory = newValue!;
                        });
                      },
                      items: <String>['Uno', 'Dos', 'Tres', 'Cuatrooooooo']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ), 
                textoCabecera("Elige el nombre sobre el que quiere realizar la consulta:", MediaQuery.of(context).size.width),    
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width-10,
                    decoration: BoxDecoration(
                      color: Color(0x44000000),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.black,
                      hint: Text("Selecciona la el nombre", style: TextStyle(color: Colors.white),),
                      isExpanded: true,
                      value: dropdownName,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.yellowAccent.shade700,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownName = newValue!;
                        });
                      },
                      items: <String>['Un nombre', 'Dos nombres', 'Tres nombres', 'Cuatrooooooo nombres']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                )
              ]
            )
          ]
        ),
      ),
    );
  }
}

Widget textoCabecera(String text, double ancho){
  return Container(
    width: ancho,
    child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
  );
}
  