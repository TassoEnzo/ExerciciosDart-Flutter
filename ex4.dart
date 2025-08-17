class Laptop{
  var Id, ram, clockCPU;
  String nome, utilizacao;

  Laptop.intenet(this.utilizacao, this.nome, this.Id, this.ram, this.clockCPU);
  Laptop.escritorio(this.utilizacao, this.nome, this.Id, this.ram, this.clockCPU);
  Laptop.programacao(this.utilizacao, this.nome, this.Id, this.ram, this.clockCPU);

  void apresentar(){
    print("$utilizacao \nNome: $nome \nId: $Id \nRam: $ram GB\nclockCPU: $clockCPU GHz");
  }
}

void main(){
  Laptop l1 = Laptop.intenet("Laptop para navegação na intenet", "Asus", 1234, 8, 3.5);
  Laptop l2 = Laptop.escritorio("Laptop para uso em escritorio", "Acer", 3434, 32, 5);
  Laptop l3 = Laptop.programacao("Laptop para progrmação", "Lenovo", 7897, 16, 4);

  l1.apresentar();
  l2.apresentar();
  l3.apresentar();
}