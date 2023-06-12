class UnsplashPhoto {
  UnsplashPhoto({
    String id = "",
    int width = 1,
    int height = 1,
    String color = "",
    String description = "",
    String altDescription = "",
    Urls? urls,
    int likes = 0,
    User? user,
  }) {
    _id = id;
    _width = width;
    _height = height;
    _color = color;
    _description = description;
    _altDescription = altDescription;
    _urls = urls ?? Urls();
    _likes = likes;
    _user = user ?? User();
  }

  UnsplashPhoto.fromJson(dynamic json) {
    _id = json['id'] ?? "";
    _width = json['width'] ?? 1;
    _height = json['height'] ?? 1;
    _color = json['color'] ?? "";
    _description = json['description'] ?? "";
    _altDescription = json['alt_description'] ?? "";
    _urls = json['urls'] != null ? Urls.fromJson(json['urls']) : Urls();
    _likes = json['likes'] ?? 0;
    _user = json['user'] != null ? User.fromJson(json['user']) : User();
  }

  String _id = "";
  int _width = 1;
  int _height = 1;
  String _color = "";
  String _description = "";
  String _altDescription = "";
  Urls _urls = Urls();
  int _likes = 0;
  User _user = User();

  String get id => _id;

  int get width => _width;

  int get height => _height;

  String get color => _color;

  String get description => _description;

  String get altDescription => _altDescription;

  Urls get urls => _urls;

  int get likes => _likes;

  User get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['width'] = _width;
    map['height'] = _height;
    map['color'] = _color;
    map['description'] = _description;
    map['alt_description'] = _altDescription;
    map['urls'] = _urls.toJson();
    map['likes'] = _likes;
    map['user'] = _user.toJson();
    return map;
  }
}

class User {
  User({
    String id = "",
    String username = "",
    String name = "",
    String bio = "",
    String location = "",
    ProfileImage? profileImage,
  }) {
    _id = id;
    _username = username;
    _name = name;
    _bio = bio;
    _location = location;
    _profileImage = profileImage ?? ProfileImage();
  }

  User.fromJson(dynamic json) {
    _id = json['id'] ?? "";
    _username = json['username'] ?? "";
    _name = json['name'] ?? "";
    _bio = json['bio'] ?? "";
    _location = json['location'] ?? "";
    _profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : ProfileImage();
  }

  String _id = "";
  String _username = "";
  String _name = "";
  String _bio = "";
  String _location = "";
  ProfileImage _profileImage = ProfileImage();

  String get id => _id;

  String get username => _username;

  String get name => _name;

  String get bio => _bio;

  String get location => _location;

  ProfileImage get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['name'] = _name;
    map['bio'] = _bio;
    map['location'] = _location;
    map['profile_image'] = _profileImage.toJson();
    return map;
  }
}

class ProfileImage {
  ProfileImage({
    String small = "",
    String medium = "",
    String large = "",
  }) {
    _small = small;
    _medium = medium;
    _large = large;
  }

  ProfileImage.fromJson(dynamic json) {
    _small = json['small'] ?? "";
    _medium = json['medium'] ?? "";
    _large = json['large'] ?? "";
  }

  String _small = "";
  String _medium = "";
  String _large = "";

  String get small => _small;

  String get medium => _medium;

  String get large => _large;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['small'] = _small;
    map['medium'] = _medium;
    map['large'] = _large;
    return map;
  }
}

class Urls {
  Urls({
    String raw = "",
    String full = "",
    String regular = "",
    String small = "",
    String thumb = "",
    String smallS3 = "",
  }) {
    _raw = raw;
    _full = full;
    _regular = regular;
    _small = small;
    _thumb = thumb;
    _smallS3 = smallS3;
  }

  Urls.fromJson(dynamic json) {
    _raw = json['raw'] ?? "";
    _full = json['full'] ?? "";
    _regular = json['regular'] ?? "";
    _small = json['small'] ?? "";
    _thumb = json['thumb'] ?? "";
    _smallS3 = json['small_s3'] ?? "";
  }

  String _raw = "";
  String _full = "";
  String _regular = "";
  String _small = "";
  String _thumb = "";
  String _smallS3 = "";

  String get raw => _raw;

  String get full => _full;

  String get regular => _regular;

  String get small => _small;

  String get thumb => _thumb;

  String get smallS3 => _smallS3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = _raw;
    map['full'] = _full;
    map['regular'] = _regular;
    map['small'] = _small;
    map['thumb'] = _thumb;
    map['small_s3'] = _smallS3;
    return map;
  }
}
