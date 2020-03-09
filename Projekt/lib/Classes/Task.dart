class Task {

  String _name;

  bool _done;
  String _where;
  DateTime _date;
  int _group_id;


  Task(this._name, this._done, this._where, this._date, this._group_id);

  String get name => _name;

  bool get done => _done;

  int get group_id => _group_id;

  String get where => _where;

  DateTime get date => _date;

  set group_id(int value) {
    _group_id = value;
  }

  set name(String value) {
    _name = value;
  }

  set date(DateTime value) {
    _date = value;
  }

  set where(String value) {
    _where = value;
  }

  set done(bool value) {
    _done = value;
  }
}