import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/Cubit/Cubit.dart';
import 'package:todo/shared/Cubit/States.dart';
import 'package:todo/shared/component/Components.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, AppStates) {},
      builder: (context, AppStates) {
        var Tasks = AppCubit.get(context).newTasks;
        return ConditionalBuilder(
          condition: Tasks.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(Tasks[index], context),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
            itemCount: Tasks.length,
          ),
          fallback: (context) => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_outlined,
                  size: 150,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No Tasks Yet',
                  style: TextStyle(fontSize: 40,color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
