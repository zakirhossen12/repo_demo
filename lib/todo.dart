import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final List<Map<String, String>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty &&
        _contactNameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          'task': _taskController.text,
          'contact': _contactNameController.text,
          'phone': _phoneController.text,
        });
      });
      _taskController.clear();
      _contactNameController.clear();
      _phoneController.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _editTask(int index, Map<String, String> updatedTask) {
    setState(() {
      _tasks[index] = updatedTask;
    });
  }

  List<Map<String, String>> _filteredTasks() {
    if (_searchController.text.isEmpty) {
      return _tasks;
    } else {
      return _tasks.where((task) {
        return task['contact']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            task['phone']!.contains(_searchController.text);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTasks().length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(_filteredTasks()[index]['task']!),
                      subtitle: Text(
                        '${_filteredTasks()[index]['contact']} - ${_filteredTasks()[index]['phone']}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Edit task
                              _taskController.text =
                                  _filteredTasks()[index]['task']!;
                              _contactNameController.text =
                                  _filteredTasks()[index]['contact']!;
                              _phoneController.text =
                                  _filteredTasks()[index]['phone']!;
                              _editTask(index, {
                                'task': _taskController.text,
                                'contact': _contactNameController.text,
                                'phone': _phoneController.text,
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTask(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        hintText: 'Task Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: _contactNameController,
                      decoration: InputDecoration(
                        hintText: 'Contact Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
