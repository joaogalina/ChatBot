import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final _userInput = TextEditingController();
  final void Function(String) onSubmit;

  InputForm(this.onSubmit);

  _submitForm() {
    if (_userInput.text.isNotEmpty) {
      onSubmit(_userInput.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextField(
            controller: _userInput,
            onSubmitted: (_) => _submitForm,
            decoration: InputDecoration(
              hintText: 'Fale com o bot aqui!',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(4),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 11, 0),
              child: ElevatedButton(
                onPressed: () => _submitForm(),
                child: Text('Enviar'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
