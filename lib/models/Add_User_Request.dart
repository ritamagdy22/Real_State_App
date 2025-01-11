
class AddUserRequest {
    String? name;
    String? email;
    String? phone;
    String? role;

    AddUserRequest({this.name, this.email, this.phone, this.role});

    AddUserRequest.fromJson(Map<String, dynamic> json) {
        name = json["name"];
        email = json["email"];
        phone = json["phone"];
        role = json["role"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["name"] = name;
        _data["email"] = email;
        _data["phone"] = phone;
        _data["role"] = role;
        return _data;
    }
}
