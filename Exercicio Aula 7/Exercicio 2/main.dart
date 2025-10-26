import 'dart:async';

Future<String> mayFailOperation(bool fail) async {
  await Future.delayed(const Duration(seconds: 1));
  if (fail) {
    throw Exception('Falha proposital na operação assíncrona');
  }
  return 'Sucesso!';
}

Future<void> tryCatchExample() async {
  try {
    print('Executando mayFailOperation(true)...');
    var result = await mayFailOperation(true);
    print('Resultado: $result');
  } catch (e, st) {
    print('Capturado erro no try/catch: $e');
  }
}

Future<void> catchErrorExample() {
  return mayFailOperation(true).then((value) {
    print('Resultado then: $value');
  }).catchError((e) {
    print('Capturado com catchError: $e');
  });
}

Future<void> rethrowExample() async {
  try {
    await mayFailOperation(true);
  } catch (e) {
    print('Tratando parcialmente e rethrow: $e');
    rethrow;
  }
}

Future<void> main() async {
  print('Atividade 2: tratamento de erros\n');

  await tryCatchExample();
  await catchErrorExample();

  try {
    await rethrowExample();
  } catch (e) {
    print('Erro recebido no main após rethrow: $e');
  }

  try {
    var success = await mayFailOperation(false);
    print('Operacao bem sucedida: $success');
  } catch (e) {
    print('Não deveria acontecer: $e');
  }

  print('\nAtividade 2 finalizada.');
}


