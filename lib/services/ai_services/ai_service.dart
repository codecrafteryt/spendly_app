import 'package:cloud_functions/cloud_functions.dart';
import 'package:spendly_app/data/models/quiz_model/spender_type.dart';

class AiService {
  AiService({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  final FirebaseFunctions _functions;

  Future<String> generateReport({
    required SpenderType spenderType,
    required Map<String, int> scores,
    required Map<String, String> answers,
  }) async {
    final callable = _functions.httpsCallable('generateReport');
    final result = await callable.call<Map<String, dynamic>>({
      'spenderType': spenderType.label,
      'scores': scores,
      'answers': answers,
    });
    final data = result.data;
    final text = data['reportText'] as String?;
    if (text == null || text.isEmpty) {
      throw Exception('Empty report from server');
    }
    return text;
  }
}
