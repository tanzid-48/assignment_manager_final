import 'package:flutter/material.dart';
import '../models/assignment.dart';
import '../database/database_helper.dart';

class AddAssignmentScreen extends StatefulWidget {
  final Assignment? assignment;
  
  const AddAssignmentScreen({super.key, this.assignment});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedSubject;
  DateTime? _selectedDeadline;
  String _selectedStatus = 'Pending';
  bool _isLoading = false;

  final List<String> _subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'Computer Science',
    'English',
    'History',
    'Economics',
    'Programming',
    'Database',
    'Software Engineering',
    'Mobile App Development',
    'Web Development',
    'Other',
  ];

  final List<String> _statuses = ['Pending', 'In-Progress', 'Completed'];

  @override
  void initState() {
    super.initState();
    if (widget.assignment != null) {
      _titleController.text = widget.assignment!.title;
      _descriptionController.text = widget.assignment!.description;
      _selectedSubject = widget.assignment!.subject;
      _selectedStatus = widget.assignment!.status;
      try {
        _selectedDeadline = DateTime.parse(widget.assignment!.deadline);
      } catch (e) {
        _selectedDeadline = null;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _selectedDeadline = picked);
    }
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<void> _saveAssignment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a subject'), backgroundColor: Colors.red),
      );
      return;
    }

    if (_selectedDeadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a deadline'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final assignment = Assignment(
        id: widget.assignment?.id,
        title: _titleController.text.trim(),
        subject: _selectedSubject!,
        description: _descriptionController.text.trim(),
        deadline: _selectedDeadline!.toIso8601String(),
        status: _selectedStatus,
        createdAt: widget.assignment?.createdAt,
      );

      if (widget.assignment == null) {
        final id = await DatabaseHelper.instance.create(assignment);
        print('✅ Assignment created with ID: $id');
      } else {
        await DatabaseHelper.instance.update(assignment);
        print('✅ Assignment updated');
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.assignment == null ? 'Assignment added!' : 'Assignment updated!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('❌ Error saving: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.assignment == null ? 'Add Assignment' : 'Edit Assignment'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Assignment Title *',
                        hintText: 'e.g., Chapter 5 Homework',
                        prefixIcon: const Icon(Icons.title),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a title' : null,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      decoration: InputDecoration(
                        labelText: 'Subject *',
                        prefixIcon: const Icon(Icons.subject),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: _subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setState(() => _selectedSubject = v),
                      validator: (v) => v == null ? 'Please select a subject' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Add details...',
                        prefixIcon: const Icon(Icons.description),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: _selectDeadline,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Deadline *',
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          _selectedDeadline == null ? 'Select deadline' : _formatDate(_selectedDeadline!),
                          style: TextStyle(color: _selectedDeadline == null ? Colors.grey : Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Status *', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: _statuses.map((status) {
                        final isSelected = _selectedStatus == status;
                        Color color = status == 'Completed' ? Colors.green : (status == 'In-Progress' ? Colors.orange : Colors.red);
                        return ChoiceChip(
                          label: Text(status),
                          selected: isSelected,
                          onSelected: (_) => setState(() => _selectedStatus = status),
                          selectedColor: color.withOpacity(0.3),
                          labelStyle: TextStyle(color: isSelected ? color : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                          avatar: isSelected ? Icon(Icons.check_circle, size: 18, color: color) : null,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _saveAssignment,
                      icon: const Icon(Icons.save),
                      label: Text(widget.assignment == null ? 'Save Assignment' : 'Update Assignment', style: const TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
