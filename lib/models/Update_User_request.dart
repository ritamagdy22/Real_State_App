
class UpdateUserRequest {
    String? name;
    String? email;

    UpdateUserRequest({this.name, this.email});

    UpdateUserRequest.fromJson(Map<String, dynamic> json) {
        name = json["name"];
        email = json["email"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["name"] = name;
        _data["email"] = email;
        return _data;
    }
}