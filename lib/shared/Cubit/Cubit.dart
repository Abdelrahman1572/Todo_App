import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/ArchivedTasks.dart';
import 'package:todo/modules/DoneTasks.dart';
import 'package:todo/modules/NewTasks.dart';
import 'package:todo/shared/Cubit/States.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var currentindex = 0;

  List<Widget> Screen = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks(),
  ];

  List<String> Title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created!');
        database
            .execute(
                'CREATE TABLE Tasks(Id INTEGER PRIMARY KEY , Title TEXT , Date TEXT , Time TEXT , Status TEXT)')
            .then((value) {
          print('Table Created!');
        }).catchError((error) {
          print('Error When Created Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened!');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String Title,
    required String Date,
    required String Time,
  }) async{
     await database.transaction((txn){
       return txn.rawInsert(
              'INSERT INTO Tasks(Title,Date,Time,Status) VALUES("$Title","$Date","$Time","new")')
          .then((value) {
        print('$value Inserted Successfully!');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((Error) {
        print('Error When Inserting New Record${Error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database){
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element) {
        if (element['Status'] == 'new') {
          newTasks.add(element);
        } else if (element['Status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  IconData FabIcon = Icons.edit;
  bool IsBottomSheetShown = false;

  void UpdateData({
    required String Status,
    required int Id,
  }) {
    database.rawUpdate('UPDATE Tasks SET Status = ? WHERE Id = ? ',
        ['$Status', Id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void DeleteData({
    required int Id,
  }) {
    database.rawDelete('DELETE FROM Tasks WHERE Id = ?',
        [Id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void ChangeBottomSheetState({
    required bool IsShow,
    required IconData icon,
  }) {
    IsBottomSheetShown = IsShow;
    FabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
