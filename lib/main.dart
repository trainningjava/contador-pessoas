import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Contador",
    home: Home()
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final int _qtdeMaxima = 20;
  final Color _primary = Colors.blue;
  final Color _secondary = Colors.red;
  final String _situacaoFull = "Lotado";
  final String _situacaoNotFull = "Há vagas";  

  int _pessoas = 0;
  String _situacao = "Há vagas";

  Color colorSituacao = Colors.blue;
  bool _isEnabledEntrou = true;
  bool _isEnabledSaiu = false;
  bool kDebugMode=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: ExactAssetImage('assets/images/Flutter01.jpg'),
          fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Text(
              'Situação: $_situacao',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: colorSituacao,
              ),
            ),
            const Text(
              'Qtde de pessoas',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$_pessoas',
              style: const TextStyle(
                fontSize: 100,
                color: Colors.green,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  TextButton(style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: isFull ? Colors.yellow.withOpacity(0.2) : Colors.yellow,
                    fixedSize: const Size(100, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: _isEnabledEntrou ? () {catracaPessoas(1);} : null, 
                  child: const Text("Entrou")),

                  const SizedBox(width: 10),

                  const SizedBox(height: 100),
                  TextButton(style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: isEmpty ? Colors.yellow.withOpacity(0.2) : Colors.yellow,
                    fixedSize: const Size(100, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: _isEnabledSaiu ? () {catracaPessoas(-1);} : null , 
                  child: const Text("Saiu"))
                ]
            ),
          ],
        ),
      ),
    );
  }

  void catracaPessoas(int value) {
    setState(() {
      _pessoas += value;
      if(isFull) {
        _pessoas = _qtdeMaxima;
        _situacao = _situacaoFull;
        colorSituacao = _secondary;
        _isEnabledEntrou = !_isEnabledEntrou;
      } else {
        if(isEmpty) {
          _pessoas = 0;
           _isEnabledSaiu = !_isEnabledSaiu;
        } else {
          if (!_isEnabledSaiu) {
            _isEnabledSaiu = true;
          }
        }
        if (!_isEnabledEntrou) {
          _isEnabledEntrou = true;
        }
        _situacao = _situacaoNotFull;
        colorSituacao = _primary;
      }
      if (kDebugMode) {
        print("qtde=$_pessoas, situação=$_situacao");
      }
    });
  }

  bool get isEmpty => _pessoas <= 0;

  bool get isFull =>  _pessoas >= _qtdeMaxima;

}
