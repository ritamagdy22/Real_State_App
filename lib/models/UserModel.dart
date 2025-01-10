
class UserModel {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? role;
    String? profileImage;
    String? introVideo;
    String? createdAt;
    String? updatedAt;

    UserModel({this.id, this.name, this.email, this.phone, this.role, this.profileImage, this.introVideo, this.createdAt, this.updatedAt});

    UserModel.fromJson(Map<String, dynamic> json) {
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
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["name"] = name;
        data["email"] = email;
        data["phone"] = phone;
        data["role"] = role;
        data["profile_image"] = profileImage;
        data["intro_video"] = introVideo;
        data["created_at"] = createdAt;
        data["updated_at"] = updatedAt;
        return data;
    }
}
