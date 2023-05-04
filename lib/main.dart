import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//NURSYAFIQAH BINTI ROSTUAH 285036

//API - allow developer to retrieve data 
void main() { 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Country Information App',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
     
      home: const HomePage(title: "Basic Country Information App"),
    );
  }
}

class HomePage extends StatefulWidget {
const HomePage({super.key, required this.title});

final String title;

  @override
State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  String desc = "  ";
  TextEditingController countryInfoController = TextEditingController();
  String countryFlag = "";
  String countryCode = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text(widget.title),
      ),
    body: Center (
      child: Column(
      mainAxisAlignment : MainAxisAlignment.center,
      children : <Widget> 
      [ const Text(" Search Country : ", 
      style : TextStyle(fontSize: 20, 
      fontWeight: FontWeight.bold)),
      const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 250.0,
              height: 50.0,
              child : TextField(
              controller: countryInfoController,
              decoration: InputDecoration(
                hintText: "Country Name ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            ),

      ElevatedButton(
        
        onPressed: _getCountry, child: 
        const Text("Load Information"),),
        
      if (countryFlag != "") ...[
              Image.network('https://flagsapi.com/$countryCode/flat/64.png'),
            ],

       //text 
      
      SizedBox(
              width: 300.0,
              height: 250.0,
              child :Text(desc, style: 
              const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold)),
          
            ),
            

      
      ], 
    ),
    ),
    );
  }
  

Future<void> _getCountry() async {
    String country = (countryInfoController.text);
countryFlag = " ";
    var res = 0;
    var url = Uri.parse(
        'https://api.api-ninjas.com/v1/country?name=$country');
    var response = await http.get(url, headers: {
      'x-api-key': 'ZzTE/VFgB4Ma02acCojS5w==Onu6NUAGM5AleTQd'
    });

res = response.statusCode;
if(res== 200){
String jsonData = response.body;
var parsedJson = json.decode(jsonData);

if (parsedJson.isEmpty){
        setState(() {
          desc = "No country is found. Please insert new country name.";
          countryFlag = "";
        });
      }

else {
setState(() {
  countryCode = parsedJson[0]['iso2'];
  countryFlag = 'https://flagsapi.com/$countryCode/flat/64.png';

var name = parsedJson[0]['name'];
var capital = parsedJson[0]['capital'];
var region = parsedJson[0]['region'];
var surface = parsedJson[0]['surface_area'];
var currencyCode = parsedJson[0]['currency']['code'];
var currencyName = parsedJson[0]['currency']['name'];
var population = parsedJson[0]['population'];
var urbanPopulation = parsedJson[0]['urban_population'];
var sexRatio = parsedJson[0]['sex_ratio'];
var fertility = parsedJson[0]['fertility'];
var tourists = parsedJson[0]['tourists'];
var internetUsers = parsedJson[0]['internet_users'];
var imports = parsedJson[0]['imports'];
var exports = parsedJson[0]['exports'];


desc = "Name: $name\nCapital: $capital\nRegion $region \nSurface Area : $surface \nCurrency Name: $currencyName \nCurrency Code: $currencyCode"
 "\nPopulation: $population \nUrban Population: $urbanPopulation \nSex ratio: $sexRatio \nFertility: $fertility"
 "\nTourists : $tourists \nInternet Users: $internetUsers \nImports : $imports \nExports : $exports ";
      });
  
} }else {
      setState(() {
        desc = "No record found";
      });
    }

}
}
