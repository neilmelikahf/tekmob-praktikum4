import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/api_service.dart';

class TodoDetailPage extends StatefulWidget {
  final Todo todo;
  const TodoDetailPage({required this.todo, Key? key}) : super(key: key);

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  late bool _isDone;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _isDone = widget.todo.isDone;
  }

  Future<void> _saveStatus() async {
    setState(() {
      _isSaving = true;
    });

    try {
      await ApiService().updateTodoStatus(id: widget.todo.id, isDone: _isDone);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Status todo berhasil diperbarui'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui status: $error'),
          backgroundColor: const Color(0xFFE57373),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Todo'),
        backgroundColor: const Color(0xFFFDF6F0),
        foregroundColor: const Color(0xFF6B3D4A),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.todo.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A2530),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.todo.description,
              style: const TextStyle(fontSize: 15, color: Color(0xFF6B3D4A), height: 1.5),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.schedule_rounded, size: 16, color: Color(0xFFB76E79)),
                const SizedBox(width: 6),
                Text(
                  'Dibuat pada ${widget.todo.createdAt.toLocal().toString().split('.').first}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7E4E8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: CheckboxListTile(
                title: const Text(
                  'Todo selesai',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4A2530)),
                ),
                subtitle: const Text('Centang untuk menandai todo ini sudah selesai'),
                value: _isDone,
                onChanged: (value) {
                  setState(() {
                    _isDone = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveStatus,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Simpan perubahan'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
