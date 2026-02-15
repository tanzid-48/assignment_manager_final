import 'package:flutter/material.dart';
import '../models/assignment.dart';
import '../database/database_helper.dart';
import 'add_assignment_screen.dart';

class AssignmentDetailScreen extends StatefulWidget {
  final Assignment assignment;

  const AssignmentDetailScreen({super.key, required this.assignment});

  @override
  State<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  late Assignment _assignment;

  @override
  void initState() {
    super.initState();
    _assignment = widget.assignment;
  }

  Color _getStatusColor() {
    switch (_assignment.status) {
      case 'Completed':
        return Colors.green;
      case 'In-Progress':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  bool _isOverdue() {
    try {
      final deadline = DateTime.parse(_assignment.deadline);
      return deadline.isBefore(DateTime.now()) && _assignment.status != 'Completed';
    } catch (e) {
      return false;
    }
  }

  int _getDaysRemaining() {
    try {
      final deadline = DateTime.parse(_assignment.deadline);
      return deadline.difference(DateTime.now()).inDays;
    } catch (e) {
      return 0;
    }
  }

  Future<void> _updateStatus(String newStatus) async {
    try {
      final updated = _assignment.copyWith(status: newStatus);
      await DatabaseHelper.instance.update(updated);
      setState(() => _assignment = updated);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated to $newStatus'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _deleteAssignment() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Assignment'),
        content: const Text('Are you sure? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && _assignment.id != null) {
      await DatabaseHelper.instance.delete(_assignment.id!);
      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignment deleted'), backgroundColor: Colors.green),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOverdue = _isOverdue();
    final daysRemaining = _getDaysRemaining();
    final statusColor = _getStatusColor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Details'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddAssignmentScreen(assignment: _assignment)),
              );
              if (result == true && _assignment.id != null) {
                final updated = await DatabaseHelper.instance.readAssignment(_assignment.id!);
                if (updated != null && mounted) {
                  setState(() => _assignment = updated);
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteAssignment,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [statusColor, statusColor.withOpacity(0.7)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_assignment.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  Text(_assignment.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.school, color: Colors.white70, size: 20),
                      const SizedBox(width: 8),
                      Text(_assignment.subject, style: const TextStyle(fontSize: 18, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isOverdue ? Colors.red.shade50 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isOverdue ? Colors.red : Colors.blue.shade200, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deadline', style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(_assignment.deadline),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isOverdue ? Colors.red : Colors.blue.shade700),
                      ),
                    ],
                  ),
                  if (isOverdue)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                      child: const Text('OVERDUE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    )
                  else if (_assignment.status != 'Completed')
                    Column(
                      children: [
                        Text(daysRemaining.toString(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: daysRemaining <= 2 ? Colors.orange : Colors.blue.shade700)),
                        Text(daysRemaining == 1 ? 'Day Left' : 'Days Left', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      ],
                    ),
                ],
              ),
            ),
            if (_assignment.description.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                      child: Text(_assignment.description, style: TextStyle(fontSize: 16, color: Colors.grey.shade800, height: 1.5)),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (_assignment.status != 'In-Progress')
                        ElevatedButton.icon(
                          onPressed: () => _updateStatus('In-Progress'),
                          icon: const Icon(Icons.play_circle, size: 18),
                          label: const Text('Mark In-Progress'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                        ),
                      if (_assignment.status != 'Completed')
                        ElevatedButton.icon(
                          onPressed: () => _updateStatus('Completed'),
                          icon: const Icon(Icons.check_circle, size: 18),
                          label: const Text('Mark Completed'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        ),
                      if (_assignment.status != 'Pending')
                        ElevatedButton.icon(
                          onPressed: () => _updateStatus('Pending'),
                          icon: const Icon(Icons.pending, size: 18),
                          label: const Text('Mark Pending'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Icon(Icons.access_time, size: 20, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                    Text('Created: ${_formatDate(_assignment.createdAt)}', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
