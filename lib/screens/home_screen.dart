import 'package:flutter/material.dart';
import '../models/assignment.dart';
import '../database/database_helper.dart';
import 'add_assignment_screen.dart';
import 'assignment_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Assignment> _assignments = [];
  bool _isLoading = true;
  String _currentFilter = 'All';

  @override
  void initState() {
    super.initState();
    _refreshAssignments();
  }

  Future<void> _refreshAssignments() async {
    setState(() => _isLoading = true);
    
    try {
      final assignments = await DatabaseHelper.instance.readAllAssignments();
      setState(() {
        _assignments = assignments;
        _isLoading = false;
      });
      print('📚 Loaded ${assignments.length} assignments');
    } catch (e) {
      print('❌ Error loading assignments: $e');
      setState(() => _isLoading = false);
    }
  }

  List<Assignment> get _filteredAssignments {
    if (_currentFilter == 'All') {
      return _assignments;
    }
    return _assignments.where((a) => a.status == _currentFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In-Progress':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  IconData _getSubjectIcon(String subject) {
    final s = subject.toLowerCase();
    if (s.contains('math') || s.contains('calculus')) return Icons.calculate;
    if (s.contains('science') || s.contains('physics') || s.contains('chemistry')) return Icons.science;
    if (s.contains('computer') || s.contains('programming')) return Icons.computer;
    if (s.contains('english') || s.contains('literature')) return Icons.book;
    if (s.contains('history')) return Icons.history_edu;
    return Icons.school;
  }

  bool _isOverdue(Assignment assignment) {
    try {
      final deadline = DateTime.parse(assignment.deadline);
      return deadline.isBefore(DateTime.now()) && assignment.status != 'Completed';
    } catch (e) {
      return false;
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  Future<void> _deleteAssignment(Assignment assignment) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Assignment'),
        content: Text('Delete "${assignment.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && assignment.id != null) {
      await DatabaseHelper.instance.delete(assignment.id!);
      _refreshAssignments();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignment deleted'), backgroundColor: Colors.green),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = _assignments.fold<Map<String, int>>(
      {'total': 0, 'pending': 0, 'inProgress': 0, 'completed': 0},
      (acc, assignment) {
        acc['total'] = acc['total']! + 1;
        if (assignment.status == 'Pending') acc['pending'] = acc['pending']! + 1;
        if (assignment.status == 'In-Progress') acc['inProgress'] = acc['inProgress']! + 1;
        if (assignment.status == 'Completed') acc['completed'] = acc['completed']! + 1;
        return acc;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Assignments', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() => _currentFilter = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
              const PopupMenuItem(value: 'In-Progress', child: Text('In-Progress')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshAssignments,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshAssignments,
              child: Column(
                children: [
                  // Statistics
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.blue.shade500],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('Total', stats['total']!, Icons.assignment),
                        _buildStat('Pending', stats['pending']!, Icons.pending_actions),
                        _buildStat('Active', stats['inProgress']!, Icons.play_circle),
                        _buildStat('Done', stats['completed']!, Icons.check_circle),
                      ],
                    ),
                  ),
                  // Filter chip
                  if (_currentFilter != 'All')
                    Chip(
                      label: Text('Filter: $_currentFilter'),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () => setState(() => _currentFilter = 'All'),
                    ),
                  // List
                  Expanded(
                    child: _filteredAssignments.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.assignment, size: 80, color: Colors.grey.shade300),
                                const SizedBox(height: 16),
                                Text(
                                  _currentFilter == 'All' ? 'No assignments yet!' : 'No $_currentFilter assignments',
                                  style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap + to add your first assignment',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: _filteredAssignments.length,
                            itemBuilder: (context, index) {
                              final assignment = _filteredAssignments[index];
                              final isOverdue = _isOverdue(assignment);
                              final statusColor = _getStatusColor(assignment.status);

                              return Card(
                                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: statusColor, width: 3),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AssignmentDetailScreen(assignment: assignment),
                                      ),
                                    );
                                    _refreshAssignments();
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: statusColor.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Icon(_getSubjectIcon(assignment.subject), color: statusColor),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    assignment.title,
                                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    assignment.subject,
                                                    style: TextStyle(color: Colors.grey.shade600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: statusColor,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                assignment.status,
                                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (assignment.description.isNotEmpty) ...[
                                          const SizedBox(height: 12),
                                          Text(
                                            assignment.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey.shade700),
                                          ),
                                        ],
                                        const Divider(height: 24),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 16, color: isOverdue ? Colors.red : Colors.grey),
                                            const SizedBox(width: 6),
                                            Text(
                                              'Due: ${_formatDate(assignment.deadline)}',
                                              style: TextStyle(
                                                color: isOverdue ? Colors.red : Colors.grey.shade700,
                                                fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                                              ),
                                            ),
                                            if (isOverdue) ...[
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: const Text('OVERDUE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                              ),
                                            ],
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                              onPressed: () => _deleteAssignment(assignment),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAssignmentScreen()),
          );
          _refreshAssignments();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Assignment'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildStat(String label, int count, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(count.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}
