import 'package:appstock/models/produit.dart';
import 'package:flutter/material.dart';

class CreateRow extends StatefulWidget {
  final Produit? produit;
  final ValueChanged<Produit> onSubmit;
  const CreateRow({
    Key? key,
    this.produit,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<CreateRow> createState() => _CreateRowState();
}

class _CreateRowState extends State<CreateRow> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.produit?.nom ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.produit != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit Product' : 'Add Product'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Product name'),
              validator: (value) =>
                  value != null && value.isEmpty ? 'Name is required' : null,
            ),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: 'Product price'),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                    double.parse(value);
                  } catch (e) {
                    return 'Invalid price format';
                  }
                }
                return null;
              },
            ),
            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Product quantity'),
              validator: (value) => value != null && value.isEmpty
                  ? 'Quantity is required'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // Create a new Produit instance with the entered data
              Produit newProduit = Produit(
                nom: nameController.text,
                // Convert price to double, you may adjust this based on your model
                prixUnitaire: double.parse(priceController.text),
                // Convert quantity to int, you may adjust this based on your model
                quantite: int.parse(quantityController.text),
              );

              // Pass the new Produit instance to the onSubmit callback
              widget.onSubmit(newProduit);

              // Close the dialog
              Navigator.pop(context);
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
