class Laptop{
  var Id, ram, clockCPU;
  String nome;

  Laptop(this.nome, this.Id, this.ram, this.clockCPU);

  void apresentar(){
    print("Nome: $nome \nId: $Id \nRam: $ram GB\nclockCPU: $clockCPU GHz");
  }
}

void main(){
  Laptop l1 = Laptop("Asus", 1234, 32, 5);

  l1.apresentar();
}
