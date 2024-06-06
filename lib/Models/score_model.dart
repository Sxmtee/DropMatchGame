class ScoreModel {
  int? id;
  int? score;

  ScoreModel({
    //required constructor
    required this.id,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    //function sending to server
    return {
      "id": id,
      "score": score,
    };
  }

  ScoreModel.fromMap(Map<String, dynamic> map) {
    //function retrieving from server
    id = map["id"];
    score = map["score"];
  }
}
