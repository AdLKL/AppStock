class Manager {
  int? managerId;
  String nom;
  String prenom;
  String email;
  String numTelephone;

  Manager({
    this.managerId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.numTelephone,
  });

  // Convert Warehouse object to Map
  Map<String, dynamic> toMap() {
    return {
      'manager_id': managerId,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'num_telephone': numTelephone,
    };
  }

  // Create Warehouse object from Map
  factory Manager.fromMap(Map<String, dynamic> map) {
    return Manager(
      managerId: map['manager_id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      numTelephone: map['num_telephone'],
    );
  }
}
