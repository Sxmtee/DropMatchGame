import 'package:dropmatchgame/Data/db_helper.dart';
import 'package:dropmatchgame/Models/score_model.dart';

class UserDBHelper {
  static String tableName = "User";

  //creates user & stores the data in database
  Future<void> createScore(ScoreModel user) async {
    var database = await DataBaseHelper.instance.database;
    await database!.insert(tableName, user.toMap());
  }

  //gets user from database
  Future<List<ScoreModel>> getScores() async {
    List<ScoreModel> scores = [];

    var database = await DataBaseHelper.instance.database;

    List<Map<String, dynamic>> list =
        await database!.rawQuery("SELECT * FROM $tableName");

    for (var element in list) {
      var eachScore = ScoreModel.fromMap(element);
      scores.add(eachScore);
    }
    return scores;
  }

  //updates user info in database
  Future<void> updateUser(ScoreModel user) async {
    var database = await DataBaseHelper.instance.database;
    await database!.update(
      tableName,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  //delete user from database
  Future<void> deleteUser(int id) async {
    var database = await DataBaseHelper.instance.database;
    await database!.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
