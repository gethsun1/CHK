import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';
import '../database/database_helper.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  _ProductEntryPageState createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Product Quantity'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price Per KG'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 10), // Add some vertical margin
            ElevatedButton.icon(
              onPressed: () async {
                XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                setState(() {
                  _imageFile = image;
                });
              },
              icon: Icon(Icons.camera_alt),
              label: Text('Upload Product Image'),
            ),
            SizedBox(height: 10), // Add some vertical margin
            Divider(), // Add a divider
            SizedBox(height: 10), // Add some vertical margin
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text;
                double quantity = double.parse(_quantityController.text);
                double pricePerKG = double.parse(_priceController.text);

                Product product = Product(
                  id: 0,
                  name: name,
                  quantity: quantity,
                  pricePerKG: pricePerKG,
                  image: _imageFile?.path ?? '',
                );

                await DatabaseHelper().insertProduct(product);

                _nameController.clear();
                _quantityController.clear();
                _priceController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product added successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
