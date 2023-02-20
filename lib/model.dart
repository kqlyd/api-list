class ApiResponse {
  ApiResponse({this.entries, this.count});
  final List<ApiModel>? entries;
  final int? count;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        count: json['count'],
        entries: (json['entries'] as List).map((e) => ApiModel.fromJson(e)).toList(),
      );
}

class ApiModel {
  ApiModel({this.description, this.link});
  final String? description;
  final String? link;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        link: json['Link'],
        description: json['Description'],
      );
}
