class Rack {
  int? rackId;
  int widthFree;
  int heightFree;
  int warehouseId;

  Rack({
    this.rackId,
    required this.widthFree,
    required this.heightFree,
    required this.warehouseId,
  });

  Rack copyWith({
    int? rackId,
    int? widthFree,
    int? heightFree,
    int? warehouseId,
  }) {
    return Rack(
      rackId: rackId ?? this.rackId,
      widthFree: widthFree ?? this.widthFree,
      heightFree: heightFree ?? this.heightFree,
      warehouseId: warehouseId ?? this.warehouseId,
    );
  }

  // Convert Rack object to Map
  Map<String, dynamic> toMap() {
    return {
      'rack_id': rackId,
      'width_free': widthFree,
      'height_free': heightFree,
      'warehouse_id': warehouseId,
    };
  }

  // Create Rack object from Map
  factory Rack.fromMap(Map<String, dynamic> map) {
    return Rack(
      rackId: map['rack_id'],
      widthFree: map['width_free'],
      heightFree: map['height_free'],
      warehouseId: map['warehouse_id'],
    );
  }
}
