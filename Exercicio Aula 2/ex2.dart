<<<<<<< HEAD
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
=======
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
>>>>>>> 3a656b2e9e71d4bb8465e9dc2c4dbeef97b9c1d1
