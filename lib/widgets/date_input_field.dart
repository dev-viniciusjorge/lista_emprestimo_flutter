import 'package:flutter/material.dart';
import 'package:mem_stuff/helpers/date_helper.dart';
import 'package:mem_stuff/helpers/validator_helper.dart';

class DateInputField extends StatefulWidget {
  final String label;
  final String initialValue;
  final Function(String) onSaved;

  const DateInputField({
    Key key,
    this.label,
    this.initialValue,
    this.onSaved,
  }) : super(key: key);

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  DateTime _selectDate;
  TextEditingController _controller;

  @override
  void initState() {
    if (widget.initialValue == null || widget.initialValue.isEmpty) {
      _selectDate = DateTime.now();
    } else {
      _selectDate = DateHelper.parse(widget.initialValue);
    }

    _controller = TextEditingController(text: DateHelper.format(_selectDate));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.date_range_outlined),
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelText: widget.label,
      ),
      readOnly: true,
      onTap: () => _onSelectDate(context),
      validator: ValidatorHelper.dateValidation,
      controller: _controller,
    );
  }

  _onSelectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (date != null && date != _selectDate) {
      _selectDate = date;
      _controller.text = DateHelper.format(date);
    }
  }
}
