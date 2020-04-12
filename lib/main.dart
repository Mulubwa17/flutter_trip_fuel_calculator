import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Consumption',
      theme: ThemeData(
        primarySwatch:Colors.blue
      ),
      home: FuelForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  _FuelFormState createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  final _currencies = ['Kwacha','Euro','Dollars'];
  final double _formDistance = 5.0;

  String _currency = 'Kwacha';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String result = '';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Cost Calculator',textAlign: TextAlign.center,),
        backgroundColor:Colors.blue
      ),
      body: Container(
        padding:EdgeInsets.all(20.0),
        child:Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top:_formDistance,
              bottom:_formDistance
            ),
         child: TextField(
            controller: distanceController,
            decoration: InputDecoration(
              labelText: 'Distance',
              hintText: 'Please insert number',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
            keyboardType: TextInputType.number,
         
          )),
          Padding(
            padding: EdgeInsets.only(
              top:_formDistance,
              bottom:_formDistance
            ),
         child: TextField(
            controller: avgController,
            decoration: InputDecoration(
              labelText: 'Distance per Unit',
              hintText: 'Please insert number',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
            keyboardType: TextInputType.number,
         
          )),
           Padding(
            padding: EdgeInsets.only(
              top:_formDistance,
              bottom:_formDistance
            ),
         child: 
         Row(children: <Widget>[
           Expanded( 
             child:TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'Price',
              hintText: 'Please insert number',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
            keyboardType: TextInputType.number,
         
          ))],)),
        
          Expanded( 
             child:DropdownButton<String>(
            items: _currencies.map((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value)
              );
            }).toList(),
            value: _currency,
            onChanged: (String value){
              _onDropdownChanged(value);
            },
          )),
         Container(
           padding: EdgeInsets.all(20),
           child: Text(result,style: TextStyle(
             fontSize: 20
           ),),
          ),
          Row(children: <Widget>[
          Expanded(
          child: RaisedButton(
            color: Theme.of(context).primaryColorDark,
            textColor: Theme.of(context).primaryColorLight,
            child: Text('Submit',
            textScaleFactor: 1.5),
            onPressed:(){
              setState(() {
                result  = _calculate();
              });
            } )
             ),
             Container(
                  width: _formDistance *2,
                ),
            Expanded(
            child: RaisedButton(
            color: Theme.of(context).buttonColor,
            textColor: Theme.of(context).primaryColorDark,
            child: Text('Reset',
            textScaleFactor: 1.5),
            onPressed:(){
              setState(() {
                 _reset();
              });
            } 
            ),
            ),
          
            
       
    ])
    
    ])));
  }
 void _onDropdownChanged(String value){
    setState(() {
      this._currency = value;
    });
  }


String _calculate(){
  double _distance = double.parse(distanceController.text);
   double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);

     double _totalCost = _distance / _consumption * _fuelCost;
     String _result = 'The cost of your trip is ' +  _totalCost.toStringAsFixed(2) + '' +  _currency;
     return _result;
  
}

void _reset(){
  distanceController.text='';
  avgController.text='';
  priceController.text='';
  setState(() {
    result='';
  });

}
}