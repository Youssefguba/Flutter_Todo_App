import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/theme/theme_cubit.dart';
import 'package:flutter_todo_app/cubit/todo/todo_cubit.dart';

import 'add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Todo App'),
        actions: [
          // Toggle theme button
          BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme) {
              return IconButton(
                icon: Icon(
                  theme.brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
            },
          )
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final todos = state.todos;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description ?? ''),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      todoCubit.updateTodoEntry(
                        todo.copyWith(isCompleted: value),
                      );
                    },
                  ),
                  onLongPress: () {
                    todoCubit.deleteTodoEntry(todo);
                  },
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No Todos'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
