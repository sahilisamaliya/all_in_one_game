class GameModel {
  GameModel({
    this.status,
    this.slider,
    this.suggested,
    this.newgame,
    this.toprating,
    this.topcharting,
    this.category,
  });

  GameModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['slider'] != null) {
      slider = [];
      json['slider'].forEach((v) {
        slider?.add(Slider.fromJson(v));
      });
    }
    if (json['suggested'] != null) {
      suggested = [];
      json['suggested'].forEach((v) {
        suggested?.add(Suggested.fromJson(v));
      });
    }
    if (json['newgame'] != null) {
      newgame = [];
      json['newgame'].forEach((v) {
        newgame?.add(Newgame.fromJson(v));
      });
    }
    if (json['toprating'] != null) {
      toprating = [];
      json['toprating'].forEach((v) {
        toprating?.add(Toprating.fromJson(v));
      });
    }
    if (json['topcharting'] != null) {
      topcharting = [];
      json['topcharting'].forEach((v) {
        topcharting?.add(Topcharting.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category?.add(Category.fromJson(v));
      });
    }
  }
  String? status;
  List<Slider>? slider;
  List<Suggested>? suggested;
  List<Newgame>? newgame;
  List<Toprating>? toprating;
  List<Topcharting>? topcharting;
  List<Category>? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (slider != null) {
      map['slider'] = slider?.map((v) => v.toJson()).toList();
    }
    if (suggested != null) {
      map['suggested'] = suggested?.map((v) => v.toJson()).toList();
    }
    if (newgame != null) {
      map['newgame'] = newgame?.map((v) => v.toJson()).toList();
    }
    if (toprating != null) {
      map['toprating'] = toprating?.map((v) => v.toJson()).toList();
    }
    if (topcharting != null) {
      map['topcharting'] = topcharting?.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      map['category'] = category?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.icon,
    this.gameList,
  });

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    if (json['gameList'] != null) {
      gameList = [];
      json['gameList'].forEach((v) {
        gameList?.add(GameList.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? icon;
  List<GameList>? gameList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    if (gameList != null) {
      map['gameList'] = gameList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class GameList {
  GameList({
    this.id,
    this.gameurl,
    this.gameimage,
    this.gamename,
    this.gamedes,
  });

  GameList.fromJson(dynamic json) {
    id = json['id'];
    gameurl = json['gameurl'];
    gameimage = json['gameimage'];
    gamename = json['gamename'];
    gamedes = json['gamedes'];
  }
  String? id;
  String? gameurl;
  String? gameimage;
  String? gamename;
  String? gamedes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gameurl'] = gameurl;
    map['gameimage'] = gameimage;
    map['gamename'] = gamename;
    map['gamedes'] = gamedes;
    return map;
  }
}

class Topcharting {
  Topcharting({
    this.id,
    this.gameurl,
    this.gameimage,
    this.gamename,
    this.gamedes,
  });

  Topcharting.fromJson(dynamic json) {
    id = json['id'];
    gameurl = json['gameurl'];
    gameimage = json['gameimage'];
    gamename = json['gamename'];
    gamedes = json['gamedes'];
  }
  String? id;
  String? gameurl;
  String? gameimage;
  String? gamename;
  String? gamedes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gameurl'] = gameurl;
    map['gameimage'] = gameimage;
    map['gamename'] = gamename;
    map['gamedes'] = gamedes;
    return map;
  }
}

class Toprating {
  Toprating({
    this.id,
    this.gameurl,
    this.gameimage,
    this.gamename,
    this.gamedes,
  });

  Toprating.fromJson(dynamic json) {
    id = json['id'];
    gameurl = json['gameurl'];
    gameimage = json['gameimage'];
    gamename = json['gamename'];
    gamedes = json['gamedes'];
  }
  String? id;
  String? gameurl;
  String? gameimage;
  String? gamename;
  String? gamedes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gameurl'] = gameurl;
    map['gameimage'] = gameimage;
    map['gamename'] = gamename;
    map['gamedes'] = gamedes;
    return map;
  }
}

class Newgame {
  Newgame({
    this.id,
    this.gameurl,
    this.gameimage,
    this.gamename,
    this.gamedes,
  });

  Newgame.fromJson(dynamic json) {
    id = json['id'];
    gameurl = json['gameurl'];
    gameimage = json['gameimage'];
    gamename = json['gamename'];
    gamedes = json['gamedes'];
  }
  String? id;
  String? gameurl;
  String? gameimage;
  String? gamename;
  String? gamedes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gameurl'] = gameurl;
    map['gameimage'] = gameimage;
    map['gamename'] = gamename;
    map['gamedes'] = gamedes;
    return map;
  }
}

class Suggested {
  Suggested({
    this.id,
    this.gameurl,
    this.gameimage,
    this.gamename,
    this.gamedes,
  });

  Suggested.fromJson(dynamic json) {
    id = json['id'];
    gameurl = json['gameurl'];
    gameimage = json['gameimage'];
    gamename = json['gamename'];
    gamedes = json['gamedes'];
  }
  String? id;
  String? gameurl;
  String? gameimage;
  String? gamename;
  String? gamedes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gameurl'] = gameurl;
    map['gameimage'] = gameimage;
    map['gamename'] = gamename;
    map['gamedes'] = gamedes;
    return map;
  }
}

class Slider {
  Slider({
    this.id,
    this.gameurl,
    this.gameimage,
    this.gamename,
    this.gamedes,
  });

  Slider.fromJson(dynamic json) {
    id = json['id'];
    gameurl = json['gameurl'];
    gameimage = json['gameimage'];
    gamename = json['gamename'];
    gamedes = json['gamedes'];
  }
  String? id;
  String? gameurl;
  String? gameimage;
  String? gamename;
  String? gamedes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gameurl'] = gameurl;
    map['gameimage'] = gameimage;
    map['gamename'] = gamename;
    map['gamedes'] = gamedes;
    return map;
  }
}
