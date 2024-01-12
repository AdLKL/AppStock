class Category {
  int? categoryId;
  String nom;

  Category({
    this.categoryId,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'categorie_id': categoryId,
      'nom': nom,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categorie_id'],
      nom: map['nom'],
    );
  }
}
