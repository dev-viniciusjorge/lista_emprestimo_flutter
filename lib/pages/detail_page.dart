import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mem_stuff/controllers/detail_controller.dart';
import 'package:mem_stuff/helpers/snackbar_helper.dart';
import 'package:mem_stuff/helpers/validator_helper.dart';
import 'package:mem_stuff/models/stuff_model.dart';
import 'package:mem_stuff/repositories/stuff_repository_impl.dart';
import 'package:mem_stuff/widgets/date_input_field.dart';
import 'package:mem_stuff/widgets/loading_dialog.dart';
import 'package:mem_stuff/widgets/photo_input_area.dart';
import 'package:mem_stuff/widgets/primary_button.dart';
import 'package:mem_stuff/widgets/text_input_field.dart';

class DetailPage extends StatefulWidget {
  final StuffModel stuff;

  const DetailPage({
    Key key,
    this.stuff,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = DetailController(StuffRepositoryImpl());

  @override
  void initState() {
    _controller.setId(widget.stuff?.id);
    _controller.setPhoto(widget.stuff?.photoPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stuff == null ? 'Novo empréstimo' : 'Detalhes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: _buildForm(),
      ),
    );
  }

  _buildForm() {
    var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
    );
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PhotoInputArea(
            initialValue: widget.stuff?.photoPath ?? '',
            onChanged: _controller.setPhoto,
          ),
          TextInputField(
            label: 'Produto',
            icon: Icons.description_outlined,
            initialValue: widget.stuff?.description ?? '',
            onSaved: _controller.setDescription,
          ),
          TextInputField(
            label: 'Nome',
            icon: Icons.person_outline,
            initialValue: widget.stuff?.contactName ?? '',
            onSaved: _controller.setName,
          ),
          TextFormField(
            initialValue: widget.stuff?.phone ?? '',
            onSaved: _controller.setPhone,
            decoration: InputDecoration(
              labelText: 'Telefone',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: ValidatorHelper.validatorCheck,
            keyboardType: TextInputType.phone,
            inputFormatters: [maskFormatter],
          ),
          DateInputField(
            label: 'Data do empréstimo',
            initialValue: widget.stuff?.date ?? '',
            onSaved: _controller.setDate,
          ),
          PrimaryButton(
            label: 'Salvar',
            onPressed: _onSave,
          )
        ],
      ),
    );
  }

  _onSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      LoadingDialog.show(
        context,
        message: widget.stuff == null ? 'Salvando...' : 'Atualizando...',
      );
      await _controller.save();
      LoadingDialog.hide();
      Navigator.of(context).pop();
      _onSuccessMessage();
    }
  }

  _onSuccessMessage() {
    if (widget.stuff == null) {
      SnackbarHelper.showCreateMessage(
          context: context,
          message: '${_controller.description} adicionado com suceso!');
    } else {
      SnackbarHelper.showUpdateMessage(
          context: context,
          message: '${_controller.description} foi atualizado!');
    }
  }
}
