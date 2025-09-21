<<<<<<< HEAD
import 'dart:io';

class House {
  int id;
  double price;
  String name;

  House(this.id, this.price, this.name);

  void apresentar() {
    print("Nome: $name \nId: $id \nPreço: $price");
  }
}

void main() {
  List<House> casas = []; 
  
  for (int i = 0; i < 3; i++) {
    print("Digite o nome da casa ${i + 1}:");
    String? nameInput = stdin.readLineSync() ?? "";

    print("Digite o Id da casa ${i + 1}:");
    int id = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

    print("Digite o preço da casa ${i + 1}:");
    double price = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

    casas.add(
      House(id, price, nameInput)
        ..name = "$nameInput (Cadastrada)"
    );

    print("Casa ${i + 1} cadastrada com sucesso!\n");
  }

  print("\n🏡 Casas cadastradas:");
  for (var casa in casas) {
    casa.apresentar();
  }
}
=======
import 'dart:io';

class House {
  int id;
  double price;
  String name;

  House(this.id, this.price, this.name);

  void apresentar() {
    print("Nome: $name \nId: $id \nPreço: $price");
  }
}

void main() {
  List<House> casas = []; 
  
  for (int i = 0; i < 3; i++) {
    print("Digite o nome da casa ${i + 1}:");
    String? nameInput = stdin.readLineSync() ?? "";

    print("Digite o Id da casa ${i + 1}:");
    int id = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

    print("Digite o preço da casa ${i + 1}:");
    double price = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

    casas.add(
      House(id, price, nameInput)
        ..name = "$nameInput (Cadastrada)"
    );

    print("Casa ${i + 1} cadastrada com sucesso!\n");
  }

  print("\n🏡 Casas cadastradas:");
  for (var casa in casas) {
    casa.apresentar();
  }
}
>>>>>>> 3a656b2e9e71d4bb8465e9dc2c4dbeef97b9c1d1
