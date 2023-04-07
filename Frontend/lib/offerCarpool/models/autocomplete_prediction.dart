// Code inspired from "Location Search Autocomplete in Flutter | Speed code"
// Found @ https://www.youtube.com/watch?v=3CO8pGw7fzY

class AutocompletePrediction {
  final String? description;
  final String? placeID;
  final String? reference;
  final StructuredFormatting? structuredFormatting;

  AutocompletePrediction(
      {this.description,
      this.placeID,
      this.reference,
      this.structuredFormatting});

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'] as String?,
      placeID: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
    );
  }
}

class StructuredFormatting {
  final String? mainText;
  final String? secondaryText;
  StructuredFormatting({this.mainText, this.secondaryText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
        mainText: json['main_text'] as String?,
        secondaryText: json['secondary_text'] as String?
    );
  }
}
