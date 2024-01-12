// models/produit.dart
class Produit {
  int? produitId;
  String nom;
  double prixUnitaire;
  int quantite;

  Produit({
    this.produitId,
    required this.nom,
    required this.prixUnitaire,
    required this.quantite,
  });

  // Convert the object into a Map
  Map<String, dynamic> toMap() {
    return {
      'produit_id': produitId,
      'nom': nom,
      'prix_unitaire': prixUnitaire,
      'quantite': quantite,
    };
  }

  // Create a Produit object from a Map
  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      produitId: map['produit_id']?.toInt() ?? 0,
      nom: map['nom'] ?? '',
      prixUnitaire: map['prix_unitaire'] ?? 0,
      quantite: map['quantite'] ?? 0,
    );
  }
}
