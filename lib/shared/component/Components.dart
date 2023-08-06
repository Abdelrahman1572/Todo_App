import 'package:flutter/material.dart';
import 'package:todo/shared/Cubit/Cubit.dart';

Widget DefaultFormField({
  required TextEditingController Controller,
  required TextInputType Type,
  required Validator,
  onChange,
  onSubmit,
  onTap,
  bool IsClickable = true,
  required String Label,
  required IconData Prefix,
}) =>
    TextFormField(
      controller: Controller,
      keyboardType: Type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      style: const TextStyle(fontSize: 20),
      enabled: IsClickable,
      validator: Validator,
      decoration: InputDecoration(
        labelText: Label,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelStyle: const TextStyle(fontSize: 24),
        prefixIcon: Icon(Prefix),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );

Widget buildTaskItem(Map Model, context) => Dismissible(
      key: Key(Model['Id'].toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete_rounded,size: 80,),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).DeleteData(Id: Model['Id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Container(
          width: 385,
          height: 200,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .UpdateData(Status: 'done', Id: Model['Id']);
                        },
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 35,
                        )),
                    Text(
                      '${Model['Date']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .UpdateData(Status: 'archived', Id: Model['Id']);
                        },
                        icon: const Icon(
                          Icons.archive_outlined,
                          size: 35,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      '${Model['Title']}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    '${Model['Time']}',
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
