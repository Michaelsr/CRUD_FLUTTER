import 'package:flutter/material.dart';
import 'package:flutter_crud/src/components/menu_pages.dart';
import '../db/db.dart';

class TratamientoPages extends StatefulWidget {
  const TratamientoPages({super.key});

  @override
  State<TratamientoPages> createState() => _TratamientoPagesState();
}

class _TratamientoPagesState extends State<TratamientoPages> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getTrata();
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

  // id_tratamiento
  // nombre TEXT,
  // peso TEXT,
  // edad TEXT,
  // dni TEXT,
  // telefono TEXT,
  // detalle TEXT,
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _detalleController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id_tratamiento'] == id);
      _nombreController.text = existingJournal['nombre'];
      _pesoController.text = existingJournal['peso'];
      _edadController.text = existingJournal['edad'];
      _dniController.text = existingJournal['dni'];
      _telefonoController.text = existingJournal['telefono'];
      _detalleController.text = existingJournal['detalle'];
      _totalController.text = existingJournal['total'];
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
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
              height: 5,
            ),
            TextField(
              controller: _pesoController,
              decoration: const InputDecoration(hintText: 'Peso'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _edadController,
              decoration: const InputDecoration(hintText: 'Edad'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _dniController,
              decoration: const InputDecoration(hintText: 'Dni'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _telefonoController,
              decoration: const InputDecoration(hintText: 'Telefono'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _detalleController,
              decoration: const InputDecoration(hintText: 'Detalle'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _totalController,
              decoration: const InputDecoration(hintText: 'Total'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new journal
                if (id == null) {
                  await _addTrata();
                }

                if (id != null) {
                  await _updatetrata(id);
                }

                // Clear the text fields
                _nombreController.text = '';
                _pesoController.text = '';
                _edadController.text = '';
                _dniController.text = '';
                _telefonoController.text = '';
                _detalleController.text = '';
                _totalController.text = '';

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
  Future<void> _addTrata() async {
    await SQLHelper.createTrata(
        _nombreController.text,
        _pesoController.text,
        _edadController.text,
        _dniController.text,
        _telefonoController.text,
        _detalleController.text,
        _totalController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updatetrata(int id) async {
    await SQLHelper.updateTrata(
        id,
        _nombreController.text,
        _pesoController.text,
        _edadController.text,
        _dniController.text,
        _telefonoController.text,
        _detalleController.text,
        _totalController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteTrata(
    int id,
  ) async {
    await SQLHelper.deleteTrata(id);
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
        title: const Text('Tratamiento'),
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
                      _journals[index]['dni'],
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
                                _showForm(_journals[index]['id_tratamiento']),
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteTrata(
                                _journals[index]['id_tratamiento']),
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.print_rounded),
                            onPressed: () =>
                                _showForm(_journals[index]['id_tratamiento']),
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
