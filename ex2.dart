import 'dart:io';

cadastrarFuncionario(String nome, String? cargo) {
  print("Ola! $nome, cargo: $cargo");
}

void main(){
  print("Digite seu nome:");
  String? nome = stdin.readLineSync();

  print("Digite seu cargo:\nSe não tiver aperte enter.");
  String? cargoString = stdin.readLineSync();

  String cargo = (cargoString != null && cargoString.trim().isNotEmpty) ? cargoString : "Sem cargo";
  
  cadastrarFuncionario(nome!, cargo);
}