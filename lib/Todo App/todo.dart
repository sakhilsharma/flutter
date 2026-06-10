import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
      ),
      home: const TodoHomePage(),
    );
  }
}

class Todo {
  String id;
  String title;
  bool isDone;
  DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.createdAt,
  });
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage>
    with SingleTickerProviderStateMixin {
  final List<Todo> _todos = [
    Todo(id: '1', title: 'Buy groceries', createdAt: DateTime.now()),
    Todo(
        id: '2',
        title: 'Read a book for 30 minutes',
        createdAt: DateTime.now()),
    Todo(id: '3', title: 'Go for a morning walk', createdAt: DateTime.now()),
  ];

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _filter = 'all'; // all, active, done
  late AnimationController _fabAnimController;
  late Animation<double> _fabScaleAnim;

  @override
  void initState() {
    super.initState();
    _fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fabScaleAnim = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _fabAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _fabAnimController.dispose();
    super.dispose();
  }

  List<Todo> get _filteredTodos {
    switch (_filter) {
      case 'active':
        return _todos.where((t) => !t.isDone).toList();
      case 'done':
        return _todos.where((t) => t.isDone).toList();
      default:
        return List.from(_todos);
    }
  }

  int get _doneCount => _todos.where((t) => t.isDone).length;

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _todos.insert(
        0,
        Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: text,
          createdAt: DateTime.now(),
        ),
      );
    });
    _controller.clear();
    _focusNode.unfocus();
  }

  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((t) => t.id == id);
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((t) => t.id == id);
    });
  }

  void _clearCompleted() {
    setState(() {
      _todos.removeWhere((t) => t.isDone);
    });
  }

  void _showAddTodoSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'New Task',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A2E)),
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: const Color(0xFFF5F5FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                ),
                onSubmitted: (_) {
                  _addTodo();
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _addTodo();
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() => _controller.clear());


  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTodos;
    final totalCount = _todos.length;
    final progress = totalCount == 0 ? 0.0 : _doneCount / totalCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'My Tasks',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A2E),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$_doneCount of $totalCount completed',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      if (_doneCount > 0)
                        TextButton(
                          onPressed: _clearCompleted,
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF6C63FF),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: const Text(
                            'Clear done',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFE0DFFF),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF6C63FF)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _FilterChip(
                          label: 'All',
                          count: _todos.length,
                          selected: _filter == 'all',
                          onTap: () => setState(() => _filter = 'all'),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Active',
                          count: _todos.where((t) => !t.isDone).length,
                          selected: _filter == 'active',
                          onTap: () => setState(() => _filter = 'active'),
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Done',
                          count: _doneCount,
                          selected: _filter == 'done',
                          onTap: () => setState(() => _filter = 'done'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Task list
            Expanded(
              child: filtered.isEmpty
                  ? _EmptyState(filter: _filter)
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                itemCount: filtered.length,
                itemBuilder: (ctx, i) {
                  final todo = filtered[i];
                  return _TodoCard(
                    key: ValueKey(todo.id),
                    todo: todo,
                    onToggle: () => _toggleTodo(todo.id),
                    onDelete: () => _deleteTodo(todo.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),


      floatingActionButton: ScaleTransition(
        scale: _fabScaleAnim,
        child: FloatingActionButton.extended(
          onPressed: _showAddTodoSheet,
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 4,
          icon: const Icon(Icons.add_rounded, size: 22),
          label: const Text(
            'Add Task',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

// ─── Filter Chip ────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF6C63FF) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected
              ? [
            BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ]
              : [],
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withOpacity(0.25)
                    : const Color(0xFFF0EFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : const Color(0xFF6C63FF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//To do card

class _TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _TodoCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFF5C8D),
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline_rounded,
            color: Colors.white, size: 24),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: todo.isDone
                    ? const Color(0xFF6C63FF)
                    : Colors.transparent,
                border: Border.all(
                  color: todo.isDone
                      ? const Color(0xFF6C63FF)
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: todo.isDone
                  ? const Icon(Icons.check_rounded,
                  color: Colors.white, size: 15)
                  : null,
            ),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: todo.isDone
                  ? Colors.grey.shade400
                  : const Color(0xFF1A1A2E),
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              decorationColor: Colors.grey.shade400,
            ),
          ),
          trailing: IconButton(
            icon:
            Icon(Icons.delete_outline_rounded, color: Colors.grey.shade300),
            onPressed: onDelete,
            splashRadius: 20,
          ),
        ),
      ),
    );
  }
}



class _EmptyState extends StatelessWidget {
  final String filter;
  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    //switch-->
    final message = switch (filter) {
      'done' => ('Nothing completed yet', 'Finish a task to see it here.'),
      'active' => ('All done!', 'You\'ve completed every task. Nice work!'),
      _ => ('No tasks yet', 'Tap "Add Task" to get started.'),
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEDFF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                size: 40,
                color: Color(0xFF6C63FF),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message.$1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message.$2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}