import 'package:abbasigroup/Screens/Home.dart';
import 'package:flutter/material.dart';

class SelectCompany extends StatefulWidget {
  @override
  _SelectCompanyState createState() => _SelectCompanyState();
}

class _SelectCompanyState extends State<SelectCompany> {
  int back=20;
  String company;
  String f_year;
  List companies=['Sea Fast Shipping','Sea Fast Shipping LLC','Sea Fast Shipping Agency Pvt. Ltd.','Global Shipping Logistics','Sahar Traders','Dayan Global Exprot Pvt. Ltd' ];
  List f_years=['2019 - 2020'];

  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];

  var textStyle,_currentSelectedValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(

        children: <Widget>[
          Image.asset("assets/images/$back.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,),
       Container(
         color: Colors.black45,
       ),
       Container(
         padding: EdgeInsets.all(30),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Image.asset("assets/images/fulllogo.png"),
           ],
         ),
       ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FormField<String>(
            builder: (FormFieldState<String> state) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                      labelStyle: textStyle,
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      hintText: 'Please select expense' ,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                  isEmpty: _currentSelectedValue == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _currentSelectedValue,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _currentSelectedValue = newValue;
                          state.didChange(newValue);
                        });
                      },
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
          Container(



            decoration: BoxDecoration(
                border: Border.all(color: Colors.white)

            ),
            padding: EdgeInsets.all(10),

            margin: EdgeInsets.all(10),
            child: DropdownButton(
              hint: Text("Select Your Company",style: TextStyle(color: Colors.white)),
              isExpanded: true,
              value: company,

              items: companies.map((value) {
                return DropdownMenuItem(
                  child: Text(value,style: TextStyle(fontSize: 24),),
                  value: value,

                );
              }).toList(),
              onChanged: (value) {

                setState(() {


                  company = value;
                  back=companies.indexOf(value);
                  //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                });
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white)
            ),
            padding: EdgeInsets.all(10),

            margin: EdgeInsets.all(10),
            child: DropdownButton(


              isExpanded: true,
              hint: Text("Select Financial Year",style: TextStyle(color: Colors.white)),



              value: f_year,
               items: f_years.map((value) {
                return DropdownMenuItem(
                  child: Text(value,style: TextStyle(fontSize: 24),),
                  value: value,
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  f_year = value;  //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                });
              },
            ),
          )
,
          Container(
            margin: EdgeInsets.all(20),
            child: ButtonTheme(
              minWidth: double.infinity,
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Color(0xff2a5298),
                child: Text(
                  'Continue > >',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                 if(_currentSelectedValue!=''){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => Home()),
                   );
                 }
                 else{
                   Scaffold.of(context)
                       .showSnackBar(SnackBar(content: Text("Please Select the Requirements")));

                 }
                },
              ),
            ),
          ),
        ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              Container(
                  width: 75,
                  height: 50,
                  child: Image.asset("assets/images/wedes.png")
              ),
              Text(
                "Copyright 2019 ICT Information Systems LLC, All Right Reserved",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
