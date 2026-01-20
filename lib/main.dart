import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String? errorTextWeight;
  String? errorTextHeight;

  late double imcResult;
  String imcResultMessage = "Information...";



  void resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";

      errorTextHeight = null;
      errorTextWeight = null;

      imcResultMessage = "Information...";
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  void displayImcResult() {


    if(weightController.text.isEmpty || heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Fill All the Fields!'))
      );
    }
    setState(() {
      double? weight = double.tryParse(weightController.text);
      double? height = double.tryParse(heightController.text)! / 100;
      imcResult = weight! / (height * height);

      imcResultMessage = 'Your IMC is : ${imcResult.toStringAsFixed(1)}';

      if(imcResult < 18.5) {
        imcResultMessage += '\nUnderweight';
      }
      else if(imcResult > 18.5 && imcResult < 25.9) {
        imcResultMessage += '\nHealthy Weight';
      }
      else if(imcResult > 25.9 && imcResult < 29.9) {
        imcResultMessage += '\nOverweight';
      }
      else if(imcResult > 30.0 && imcResult < 39.9) {
        imcResultMessage += '\nObesity';
      }
      else if(imcResult > 40.0) {
        imcResultMessage += '\nSevere Obesity, please take care of yourself!';
      }

      /*
      below 18.5 - underweight
      18.5 - 25.9 - healthy weight
      25.9 - 29.9 - overweight
      >30 - obesity
      >40 - severe obesity
       */
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'I M C   CALCULATOR',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: resetFields, icon: Icon(Icons.refresh)),
        ],
      ),

      backgroundColor: Colors.white,

      body: GestureDetector(
        onTap: () => {FocusScope.of(context).unfocus()},
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, size: 150, color: Colors.green),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: Text('Kg'),
                  labelText: "Weight (Kg)",
                  labelStyle: GoogleFonts.montserrat(color: Colors.green),
                  errorText: errorTextWeight,
                ),
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 20),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Height (Cm)",
                  suffix: Text('Cm'),
                  labelStyle: GoogleFonts.montserrat(color: Colors.green),
                  errorText: errorTextHeight,
                ),
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 20),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: displayImcResult,
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                  fixedSize: WidgetStatePropertyAll(Size.fromHeight(60)),
                ),
                child: Text(
                  'CALCULATE IMC',
                  style: GoogleFonts.montserrat(fontSize: 20),
                ),
              ),
              SizedBox(height: 40),
              Text(
                imcResultMessage,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Colors.green,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
