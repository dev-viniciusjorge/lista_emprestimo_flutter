import 'package:mem_stuff/helpers/date_helper.dart';

const kRequiredField = 'Campo obrigatório';

class ValidatorHelper {
  static String validatorCheck(String text) {
    if (text.isEmpty) return kRequiredField;
    return null;
  }

  static String dateValidation(String text) {
    return DateHelper.parse(text).isAfter(DateTime.now())
        ? 'Data inválida!'
        : null;
  }
}
