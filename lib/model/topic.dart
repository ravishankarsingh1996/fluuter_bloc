class Topic {
  String? topicName;
  List<Concept>? concepts;
  bool? isExpanded = false;
  bool? isSelected = false;

  Topic({this.topicName, this.concepts, this.isExpanded, this.isSelected});

  Topic.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    if (json['concepts'] != null) {
      concepts = <Concept>[];
      for (var v in json['concepts']) {
        concepts!.add(v is Map<String, dynamic> ? Concept.fromJson(v) : Concept(concept: v, isSelected: false));
      }
    }
  }

  Map<String, dynamic> toJson() {
    List<Map>? concepts =  this.concepts?.map((i) => i.toJson()).toList();
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicName'] = topicName;
    data['concepts'] = concepts;
    return data;
  }

  @override
  String toString() {
    return 'Topic{topicName: $topicName, concepts: $concepts}';
  }
}

class Concept {
  String? concept;
  bool? isSelected = false;

  Concept({this.concept, this.isSelected});

  Concept.fromJson(Map<String, dynamic> json) {
    concept = json['concept'];
    isSelected = json['isSelected'];
  }

  Map toJson() => {'concept': concept, 'isSelected': isSelected};

  @override
  String toString() {
    return 'Concept{concept: $concept, isSelected: $isSelected}';
  }
}
