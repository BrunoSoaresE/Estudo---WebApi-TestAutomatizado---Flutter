class Contato {
  final int idContato;
  final String nome;
  final int numeroConta;

  Contato(this.idContato, this.nome, this.numeroConta);

  @override
  String toString() {
    return 'Contato{idContato: $idContato,nome: $nome, numeroConta: $numeroConta}';
  }

  Contato.fromJson(Map<String, dynamic> json)
      :
        idContato = json['id'],
        nome = json['name'],
        numeroConta = json['accountNumber'];



  Map<String, dynamic> toJson() =>
      {
        'name': nome,
        'accountNumber': numeroConta,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contato &&
          runtimeType == other.runtimeType &&
          nome == other.nome &&
          numeroConta == other.numeroConta;

  @override
  int get hashCode => nome.hashCode ^ numeroConta.hashCode;
}