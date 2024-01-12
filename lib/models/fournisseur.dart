class Fournisseur {
  int? fournisseurId;
  String nom;
  String prenom;
  String email;
  String numTelephone;

  Fournisseur({
    this.fournisseurId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.numTelephone,
  });

  Map<String, dynamic> toMap() {
    return {
      'fournisseur_id': fournisseurId,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'num_telephone': numTelephone,
    };
  }

  factory Fournisseur.fromMap(Map<String, dynamic> map) {
    return Fournisseur(
      fournisseurId: map['fournisseur_id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      numTelephone: map['num_telephone'],
    );
  }
}
