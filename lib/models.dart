
class User {
  var name;
  var phoneNum;

  User({this.name, this.phoneNum});

  User returnModel(Map dataMap) {
    print("dataMap $dataMap");
    return User(name: dataMap['name'], phoneNum: dataMap['phoneNum']);
  }
}