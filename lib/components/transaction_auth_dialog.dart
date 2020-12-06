import 'package:flutter/material.dart';

const Key TransactionAuthDialogAuthenticateTextFildPass = Key('TransactionAuthDialogAuthenticateTextFildPass');

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({@required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        key: TransactionAuthDialogAuthenticateTextFildPass,
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('Confirmar'),
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
