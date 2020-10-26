import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final TextInputType keyboardType;
  final bool validation;
  final TextEditingController controller;
  final Widget prefixIcon, suffixIcon;

  const CustomTextFormField(
      {this.text,
      this.keyboardType,
      this.validation,
      this.controller,
      this.prefixIcon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          labelText: text,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.deepPurple[400]),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: new BorderSide(
              color: Colors.deepPurple[300],
            ),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String value;
  final void Function(String) onChanged;
  final List<String> list;
  final String label;

  CustomDropdown({Key key, this.label, this.value, this.onChanged, this.list});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[400]),
          ),
        ),
        Expanded(
          flex: 2,
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.deepPurple[400],
            ),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 1,
              color: Colors.black38,
            ),
            onChanged: onChanged,
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        onPressed: onPressed,
        color: Colors.deepPurple[300],
        textColor: Colors.white,
        splashColor: Colors.lightBlueAccent,
        padding: EdgeInsets.all(12.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

class FlightInfoRow extends StatelessWidget {
  final String title, content;

  const FlightInfoRow({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: [
              Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45.withOpacity(0.6)),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                "$content",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(1.0)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String text;

  const CustomAlertDialog(this.text);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: [
        RaisedButton(
            child: Text("Back"),
            color: Colors.deepPurple[200],
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}

class ShowMyDialog {
  static ShowMyDialog _instance = new ShowMyDialog.internal();

  ShowMyDialog.internal();

  factory ShowMyDialog() => _instance;

  static void showCustomDialog(
      BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple[50],
            title: Text(title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                )),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.deepPurple),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
