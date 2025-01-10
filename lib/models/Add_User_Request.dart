
class CreateUserRequest {
    String? name;
    String? email;
    String? phone;
    String? role;

    CreateUserRequest({this.name, this.email, this.phone, this.role});

    CreateUserRequest.fromJson(Map<String, dynamic> json) {
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
