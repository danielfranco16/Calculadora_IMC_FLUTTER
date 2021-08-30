import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: MyHomePage(title: 'Calculadora de IMC'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double valorResultadoIMC = 0.0; //variavel resultado imc
  double maximo = 50.0; //variavel valor máximo do gráfico
  String legendaResultado = "Informe seus dados!"; //variavel Legenda

  TextEditingController textoPeso = TextEditingController();
  TextEditingController textoAltura = TextEditingController();

  void _reseta() {
    setState(() {
      valorResultadoIMC = 0.0; //variavel resultado imc
      maximo = 50.0; //variavel valor máximo do gráfico
      legendaResultado = "Informe seus dados!"; //variavel Legenda
      textoAltura.text = ""; //controlador do TextField
      textoPeso.text = ""; //controlador do TextField
    });
  }

  void _calcula() {
    double valorPeso = double.parse(textoPeso.text);
    double valorAltura = double.parse(textoAltura.text);
    valorResultadoIMC = valorPeso / (valorAltura * valorAltura);

    setState(() {
      if (valorResultadoIMC < 18.6) {
        legendaResultado = valorResultadoIMC.toStringAsFixed(2);
        legendaResultado = 'IMC: $legendaResultado - Abaixo do Peso';
        maximo = valorResultadoIMC;
      } else if (valorResultadoIMC >= 18.6 && valorResultadoIMC < 24.9) {
        legendaResultado = valorResultadoIMC.toStringAsFixed(2);
        legendaResultado = 'IMC: $legendaResultado - Peso Ideal';
        maximo = valorResultadoIMC;
      } else if (valorResultadoIMC >= 24.9 && valorResultadoIMC < 29.9) {
        legendaResultado = valorResultadoIMC.toStringAsFixed(2);
        legendaResultado = 'IMC: $legendaResultado -  Levemente Acima do Peso';
        maximo = valorResultadoIMC;
      } else if (valorResultadoIMC >= 29.9 && valorResultadoIMC < 34.9) {
        legendaResultado = valorResultadoIMC.toStringAsFixed(2);
        legendaResultado = 'IMC: $legendaResultado - Obesidade Grau I';
        maximo = valorResultadoIMC;
      } else if (valorResultadoIMC >= 34.9 && valorResultadoIMC < 39.9) {
        legendaResultado = valorResultadoIMC.toStringAsFixed(2);
        legendaResultado = 'IMC: $legendaResultado -  Obesidade Grau II';
        maximo = valorResultadoIMC;
      } else if (valorResultadoIMC >= 40) {
        legendaResultado = valorResultadoIMC.toStringAsFixed(2);
        legendaResultado = 'IMC: $legendaResultado -  Obesidade Grau III';
        maximo = valorResultadoIMC;
      }
    });
  }

  Widget buildTextField(String labelText, TextEditingController controlador) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.green,
              fontSize: 20,
            ),
            border: OutlineInputBorder()),
        style: TextStyle(color: Colors.green, fontSize: 25.0),
        keyboardType: TextInputType.number,
        controller: controlador,
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _reseta();
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 1000, //duração da animação
                axes: <RadialAxis>[
                  RadialAxis(
                    interval: 10,
                    startAngle: 180, //angulo inicial do gráfico
                    endAngle: 360, //angulo final do gráfico
                    minimum: 0, //valor inicial
                    maximum: maximo, //valor final
                    canScaleToFit: true,
                    pointers: <GaugePointer>[
                      NeedlePointer(
                          value: valorResultadoIMC,
                          enableAnimation: true) //vALOR
                    ],
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 18.5, color: Colors.blue),
                      GaugeRange(
                          startValue: 18.6,
                          endValue: 24.9,
                          color: Colors.green),
                      GaugeRange(
                          startValue: 25, endValue: 29.9, color: Colors.yellow),
                      GaugeRange(
                          startValue: 30, endValue: 34.9, color: Colors.orange),
                      GaugeRange(
                          startValue: 35, endValue: 39.9, color: Colors.red),
                      GaugeRange(
                          startValue: 40,
                          endValue: maximo,
                          color: Colors.red[900]),
                    ],
                  )
                ],
              ),
            ),
            Text(legendaResultado,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            buildTextField("Digite sua altura", textoAltura),
            buildTextField("Digite seu peso", textoPeso),
            ElevatedButton(
                onPressed: () {
                  _calcula();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  onSurface: Colors.green[900],
                ),
                child: const Text('Calcular')),
          ],
        ),
      ),
    );
  }
}
