import 'dart:io' show File; // Only used on mobile
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  String _transactionType = 'Rent';
  bool _publishing = false;

  // Each image: {'file': XFile, 'bytes': Uint8List}
  final List<Map<String, dynamic>> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final picked = await _picker.pickMultiImage(imageQuality: 75);
    for (final xfile in picked.take(10 - _images.length)) {
      final bytes = await xfile.readAsBytes();
      _images.add({'file': xfile, 'bytes': bytes});
    }
    setState(() {});
  }

  Future<List<String>> _uploadImages(String ownerId) async {
    final storage = FirebaseStorage.instance;
    final List<String> urls = [];
    for (final img in _images) {
      final xfile = img['file'] as XFile;
      final bytes = img['bytes'] as Uint8List;

      final ref = storage.ref().child(
          'listings/$ownerId/${DateTime.now().millisecondsSinceEpoch}_${xfile.name}');

      if (kIsWeb) {
        await ref.putData(bytes); 
      } else {
        await ref.putFile(File(xfile.path)); 
      }
      urls.add(await ref.getDownloadURL());
    }
    return urls;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _images.isEmpty) {
      if (_images.isEmpty && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please add at least one photo')));
      }
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please sign in first')));
      return;
    }

    setState(() => _publishing = true);

    try {
      final ownerId = user.uid;
      final imageUrls = await _uploadImages(ownerId);
      final listingsCollection = FirebaseFirestore.instance.collection('listings');
      final docRef = listingsCollection.doc();
      final data = {
        'id': docRef.id,
        'ownerId': ownerId,
        'title': _titleCtrl.text.trim(),
        'description': _descCtrl.text.trim(),
        'transactionType': _transactionType,
        'price': double.tryParse(_priceCtrl.text.trim()) ?? 0,
        'images': imageUrls,
        'createdAt': FieldValue.serverTimestamp(),
      };
      await docRef.set(data);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Listing published successfully!')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _publishing = false);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Listing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                ),
                validator: (v) => (v == null || v.trim().length < 5)
                    ? 'Enter a descriptive title (min 5 chars)'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                minLines: 3,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                ),
                validator: (v) => (v == null || v.trim().length < 20)
                    ? 'Describe the property (min 20 chars)'
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _transactionType,
                items: const [
                  DropdownMenuItem(value: 'Rent', child: Text('For Rent')),
                  DropdownMenuItem(value: 'Buy', child: Text('For Sale')),
                ],
                onChanged: (v) => setState(() => _transactionType = v ?? 'Rent'),
                decoration: InputDecoration(
                  labelText: 'property Type',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price (₹)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1.5,
                    ),
                  ),
                ),
                validator: (v) => (v == null || double.tryParse(v) == null)
                    ? 'Enter a valid price'
                    : null,
              ),
              const SizedBox(height: 16),
              Text('Photos (${_images.length}/10)',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ..._images.map((img) {
                    final xfile = img['file'] as XFile;
                    final bytes = img['bytes'] as Uint8List;
                    return Stack(
                      children: [
                        kIsWeb
                            ? Image.memory(bytes,
                                width: 100, height: 100, fit: BoxFit.cover)
                            : Image.file(File(xfile.path),
                                width: 100, height: 100, fit: BoxFit.cover),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () => setState(() => _images.remove(img)),
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.close,
                                  color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  if (_images.length < 10)
                    GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.add_a_photo,
                            color: Colors.black54),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _publishing ? null : _submit,
                  child: _publishing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Publish Properity'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}