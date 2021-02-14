import 'dart:convert';

import 'package:meta/meta.dart';

class Card {
  final int id;
  final int seqNum;

  final String text;
  final String row;
  Card({
    @required this.id,
    @required this.seqNum,
    @required this.text,
    @required this.row,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seq_num': seqNum,
      'text': text,
      'row': row,
    };
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Card(
      id: map['id'],
      seqNum: map['seq_num'],
      text: map['text'],
      row: map['row'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) => Card.fromMap(json.decode(source));
}
