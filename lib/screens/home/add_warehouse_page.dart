import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddWarehousePage extends StatelessWidget {
  final List<Map<String, dynamic>> dummyWarehouses = [
    // Add more dummy data as needed
  ];

  // Controllers for the form fields
  final TextEditingController _warehouseNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _rackNumController = TextEditingController();
  final TextEditingController _shelfNumController = TextEditingController();
  final TextEditingController _widthFreeController = TextEditingController();
  final TextEditingController _heightFreeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: FractionallySizedBox(
              widthFactor: 0.4,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showAddWarehousePopup(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Add Warehouse',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('warehouses').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20.0,
                    headingRowHeight: 40.0,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Nom',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Adresse',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Rack Num',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Shelf Num',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Width Free',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Height Free',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                    rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return DataRow(
                        cells: [
                          DataCell(Text(data['nom'].toString())),
                          DataCell(Text(data['adresse'].toString())),
                          DataCell(Text(data['rack_num'].toString())),
                          DataCell(Text(data['shelf_num'].toString())),
                          DataCell(Text(data['width_free'].toString())),
                          DataCell(Text(data['height_free'].toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAddWarehousePopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Warehouse'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _warehouseNameController,
                    decoration: InputDecoration(labelText: 'Warehouse Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the warehouse name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _rackNumController,
                    decoration: InputDecoration(labelText: 'Rack Num'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the rack number';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid numeric value for rack number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _shelfNumController,
                    decoration: InputDecoration(labelText: 'Shelf Num'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the shelf number';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid numeric value for shelf number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _widthFreeController,
                    decoration: InputDecoration(labelText: 'Width Free'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the free width';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid numeric value for free width';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _heightFreeController,
                    decoration: InputDecoration(labelText: 'Height Free'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the free height';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid numeric value for free height';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _saveWarehouseToFirestore(
                    context,
                    _warehouseNameController.text,
                    _addressController.text,
                    int.tryParse(_rackNumController.text) ?? 0,
                    int.tryParse(_shelfNumController.text) ?? 0,
                    double.tryParse(_widthFreeController.text) ?? 0.0,
                    double.tryParse(_heightFreeController.text) ?? 0.0,
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWarehouseToFirestore(
    BuildContext context,
    String warehouseName,
    String address,
    int rackNum,
    int shelfNum,
    double widthFree,
    double heightFree,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('warehouses').add({
        'nom': warehouseName,
        'adresse': address,
        'rack_num': rackNum,
        'shelf_num': shelfNum,
        'width_free': widthFree,
        'height_free': heightFree,
      });

      print('Warehouse added successfully to Firestore');
      Navigator.of(context).pop();
    } catch (e) {
      print('Error adding warehouse to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding warehouse to Firestore'),
        ),
      );
    }
  }
}
