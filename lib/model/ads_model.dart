class AdsModel {
  String? status;
  Data? data;

  AdsModel({this.status, this.data});

  AdsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? adsClickLimit;
  String? isAdVisible;
  String? isAdVisibleLimit;
  int? topChartLength;
  int? categoryChartLength;
  String? openAdId;
  String? interAdId;
  String? mrecAdId;
  String? bannerAdId;

  Data(
      {this.adsClickLimit,
      this.isAdVisible,
      this.isAdVisibleLimit,
      this.topChartLength,
      this.categoryChartLength,
      this.openAdId,
      this.interAdId,
      this.mrecAdId,
      this.bannerAdId});

  Data.fromJson(Map<String, dynamic> json) {
    adsClickLimit = json['adsClickLimit'];
    isAdVisible = json['isAdVisible'];
    isAdVisibleLimit = json['isAdVisibleLimit'];
    topChartLength = json['topChartLength'];
    categoryChartLength = json['categoryChartLength'];
    openAdId = json['openAdId'];
    interAdId = json['interAdId'];
    mrecAdId = json['mrecAdId'];
    bannerAdId = json['bannerAdId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adsClickLimit'] = adsClickLimit;
    data['isAdVisible'] = isAdVisible;
    data['isAdVisibleLimit'] = isAdVisibleLimit;
    data['topChartLength'] = topChartLength;
    data['categoryChartLength'] = categoryChartLength;
    data['openAdId'] = openAdId;
    data['interAdId'] = interAdId;
    data['mrecAdId'] = mrecAdId;
    data['bannerAdId'] = bannerAdId;
    return data;
  }
}
