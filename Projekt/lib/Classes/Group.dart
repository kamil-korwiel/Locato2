
import 'package:pageview/Classes/ComplexTask.dart';

class Group {
  int _id;
  String _name;
  int _percent;

  Group(this._id, this._name, this._percent);

  int get id => _id;
  String get name => _name;
  int get percent => _percent;



  set name(String value) {
    _name = value;
  }
  set id(int value) {
    _id = value;
  }
  set percent(int value) {
    _percent = value;
  }
}