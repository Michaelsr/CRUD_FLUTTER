import 'package:flutter/material.dart';
import 'package:flutter_crud/src/components/menu_pages.dart';
import '../db/db.dart';

class BoletaPages extends StatefulWidget {
  const BoletaPages({super.key});

  @override
  State<BoletaPages> createState() => _BoletaPagesState();
}

class _BoletaPagesState extends State<BoletaPages> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _detalleController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id_boleta'] == id);
      _nombreController.text = existingJournal['nombre'];
      _tipoController.text = existingJournal['tipo'];
      _detalleController.text = existingJournal['detalle'];
      _valorController.text = existingJournal['valor'];
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(hintText: 'Nombre'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _tipoController,
              decoration: const InputDecoration(hintText: 'Tipo'),
            ),
            TextField(
              controller: _detalleController,
              decoration: const InputDecoration(hintText: 'Detalle'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _valorController,
              decoration: const InputDecoration(hintText: 'Valor'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new journal
                if (id == null) {
                  await _addItem();
                }

                if (id != null) {
                  await _updateItem(id);
                }

                // Clear the text fields
                _nombreController.text = '';
                _tipoController.text = '';
                _detalleController.text = '';
                _valorController.text = '';

                // Close the bottom sheet
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: Text(id == null ? 'Guardar' : 'Actualizar'),
            )
          ],
        ),
      ),
    );
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(_nombreController.text, _tipoController.text,
        _detalleController.text, _valorController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _nombreController.text, _tipoController.text,
        _detalleController.text, _valorController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(
    int id,
  ) async {
    await SQLHelper.deleteItem(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Borrado exitoso'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 9, 88, 192),
        title: const Text('Boleta'),
      ),
      drawer: const MenuPages(),
      backgroundColor: const Color.fromARGB(255, 4, 42, 92),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: const Color.fromARGB(255, 64, 141, 241),
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(
                      _journals[index]['nombre'],
                    ),
                    textColor: Colors.white,
                    subtitle: Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      "S/." + _journals[index]['valor'],
                    ),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            color: Colors.white,
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                _showForm(_journals[index]['id_boleta']),
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_journals[index]['id_boleta']),
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.print_rounded),
                            onPressed: () =>
                                _showForm(_journals[index]['id_boleta']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
