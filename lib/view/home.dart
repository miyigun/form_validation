import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //we have initialized the form key with super class FormState
  //we have initialized the form key with super class FormState
  final _formKey=GlobalKey<FormState>();

  String yourName="";
  String yourAge="";
  final _cities=["Calcutta","Delhi","Mumbai","Bangalore"];
  String _youHaveSelected="";
  String _displayText="";

  @override
  void initState() {
    super.initState();
    _youHaveSelected=_cities[0];
  }

  TextEditingController textOfAge=TextEditingController();
  TextEditingController textOfName=TextEditingController();

  void selectedDropDownItem(String theValueSelected) {
    setState(() {
      _youHaveSelected=theValueSelected;
    });
  }

  String displayAllSelectedValue() {
    String name=textOfName.text;
    int age=int.parse(textOfAge.text);
    String city=_youHaveSelected;

    String displayAllSelectedValues="Your name is $name, your age is $age and you live in $city";

    return displayAllSelectedValues;
  }

  void _resetButton() {
    textOfName.text="";
    textOfAge.text="";
    _youHaveSelected=_cities[0];
    _displayText="";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      //we have changed the previous container widget to Form
      //since Form does not allow margin, we need to add some padding around ListView
      body: Form(
        //later this key will act as an identifier
        //and it will let us know the current status of the form
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(10.0),
                child: Text(
                  'Type your name, age, and select the city from the drop down menu be low.',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              //we will change the TextField to TextFormField so that we can use the validator
              TextFormField(
                keyboardType: TextInputType.text,
                controller: textOfName,
                validator: (String? validationValue){
                  if (validationValue!.isEmpty) {
                    return "Please fill up the form with correct input";
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
                //because we are using TextFormField, and use the validation
                // we can use customize the error style
                decoration: InputDecoration(
                  labelText: "Your Name",
                  hintText: "In text...",
                  labelStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.red,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: textOfAge,
                validator: (String? validationValue){
                  if (validationValue!.isEmpty) {
                    return "Please fill up the form with correct input!";
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  labelText: "Your age",
                  hintText: "In number...",
                  labelStyle: const TextStyle(
                    fontSize:17,
                    color: Colors.red,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.only(left: 32, top: 10),
                child: DropdownButton<String>(
                  items: _cities.map((String nameOfCities) {
                    return DropdownMenuItem<String>(
                      value:  nameOfCities,
                        child: Text(nameOfCities),
                    );
                  }).toList(),
                  onChanged: (String? theValueSelected) {
                    selectedDropDownItem(theValueSelected!);
                  },
                  value: _youHaveSelected,
                  iconSize: 50,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      child: const Text(
                        "Press",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.redAccent,
                        ),
                      ),
                      onPressed: (){
                        setState(() {
                          //if the form's current state validates, only then proceed
                          if (_formKey.currentState!.validate()) {
                            _displayText=displayAllSelectedValue();
                          }
                        });
                      },
                    ),
                  ),
                  Container(width: 25,),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.yellow,
                        ),
                      ),
                      onPressed: (){
                        setState(() {
                          _resetButton();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  _displayText,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
