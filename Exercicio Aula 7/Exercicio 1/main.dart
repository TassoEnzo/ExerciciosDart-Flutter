import 'dart:async';

Future<String> fetchUserOrder() {
  return Future.delayed(
    const Duration(seconds: 2),
    () => 'Large Latte',
  );
}

String createOrderMessageSync() {
  var order = fetchUserOrder();
  return 'Seu pedido é: $order';
}

Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return 'Seu pedido é: $order';
}

Future<void> main() async {
  print('Iniciando Atividade 1 (async/await)');

  print('\n-- Exemplo incorreto (não usar await):');
  print(createOrderMessageSync());

  print('\n-- Exemplo correto (com await):');
  var message = await createOrderMessage();
  print(message);

  print('\nAtividade 1 finalizada.');
}

