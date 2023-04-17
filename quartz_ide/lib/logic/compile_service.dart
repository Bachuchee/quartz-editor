import 'package:http/http.dart' as http;

// A class to communicate with the compiler server to compile the result
class CompilerService {
  static const serverUrl = 'http://127.0.0.1:8080/compile/';

  static Future<CompileResult> compile(String codeContent) async {
    final response = await http.post(
      Uri.parse(serverUrl),
      body: codeContent,
    );
    return CompileResult(response.body, response.statusCode == 400);
  }
}

class CompileResult {
  const CompileResult(this.compileResult, this.isError);
  final String compileResult;
  final bool isError;
}
