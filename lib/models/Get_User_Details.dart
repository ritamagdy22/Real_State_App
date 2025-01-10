
class GetUserDetails {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? role;
    String? profileImage;
    String? introVideo;
    String? createdAt;
    String? updatedAt;

    GetUserDetails({this.id, this.name, this.email, this.phone, this.role, this.profileImage, this.introVideo, this.createdAt, this.updatedAt});

    GetUserDetails.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        email = json["email"];
        phone = json["phone"];
        role = json["role"];
        profileImage = json["profile_image"];
        introVideo = json["intro_video"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["email"] = email;
        _data["phone"] = phone;
        _data["role"] = role;
        _data["profile_image"] = profileImage;
        _data["intro_video"] = introVideo;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        return _data;
    }
}