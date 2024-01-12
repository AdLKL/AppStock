class Warehouse {
  int? warehouseId;
  String nom;
  String pays;
  String ville;
  String quartier;
  int numero;
  int managerId;

  Warehouse({
    this.warehouseId,
    required this.nom,
    required this.pays,
    required this.ville,
    required this.quartier,
    required this.numero,
    required this.managerId,
  });

  // Convert Warehouse object to Map
  Map<String, dynamic> toMap() {
    return {
      'warehouse_id': warehouseId,
      'nom': nom,
      'pays': pays,
      'ville': ville,
      'quartier': quartier,
      'numero': numero,
      'manager_id': managerId,
    };
  }

  // Create Warehouse object from Map
  factory Warehouse.fromMap(Map<String, dynamic> map) {
    return Warehouse(
      warehouseId: map['warehouse_id'],
      nom: map['nom'],
      pays: map['pays'],
      ville: map['ville'],
      quartier: map['quartier'],
      numero: map['numero'],
      managerId: map['manager_id'],
    );
  }
}
