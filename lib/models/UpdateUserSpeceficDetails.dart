
class UpdateUserSpeceficDetails {
    String? message;
    User? user;

    UpdateUserSpeceficDetails({this.message, this.user});

    UpdateUserSpeceficDetails.fromJson(Map<String, dynamic> json) {
        message = json["message"];
        user = json["user"] == null ? null : User.fromJson(json["user"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["message"] = message;
        if(user != null) {
            _data["user"] = user?.toJson();
        }
        return _data;
    }
}

class User {
    String? name;
    String? email;
    String? updatedAt;
    String? createdAt;
    int? id;

    User({this.name, this.email, this.updatedAt, this.createdAt, this.id});

    User.fromJson(Map<String, dynamic> json) {
        name = json["name"];
        email = json["email"];
        updatedAt = json["updated_at"];
        createdAt = json["created_at"];
        id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["name"] = name;
        _data["email"] = email;
        _data["updated_at"] = updatedAt;
        _data["created_at"] = createdAt;
        _data["id"] = id;
        return _data;
    }
}