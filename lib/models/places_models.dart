// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

import 'dart:convert';

class PlacesResponse {
    PlacesResponse({
      required  this.type,
       required this.query,
       required this.features,
       required this.attribution,
    });

    final String type;
    final List<String> query;
    final List<Feature> features;
    final String attribution;

    factory PlacesResponse.fromRawJson(String str) => PlacesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
      required  this.id,
      required  this.type,
      required  this.placeType,
      required  this.properties,
      required  this.textEs,
      required  this.languageEs,
      required  this.placeNameEs,
      required  this.text,
      required  this.language,
      required  this.placeName,
      required  this.center,
      required  this.geometry,
       required this.context,
    });

    final String id;
    final String type;
    final List<String> placeType;
    final Properties properties;
    final String textEs;
    final Language? languageEs;
    final String placeNameEs;
    final String text;
    final Language? language;
    final String placeName;
    final List<double> center;
    final Geometry geometry;
    final List<Context> context;

    factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        languageEs: languageValues.map[json["language_es"]],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: languageValues.map[json["language"]],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es": languageValues.reverse[languageEs],
        "place_name_es": placeNameEs,
        "text": text,
        "language": languageValues.reverse[language],
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
    };
}

class Context {
    Context({
      required  this.id,
      required  this.mapboxId,
      required  this.textEs,
      required  this.text,
      required  this.wikidata,
      required  this.languageEs,
      required  this.language,
       required this.shortCode,
    });

    final String id;
    final String? mapboxId;
    final String textEs;
    final String text;
    final String? wikidata;
    final Language? languageEs;
    final Language? language;
    final ShortCode? shortCode;

    factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        languageEs: languageValues.map[json["language_es"]],
        language: languageValues.map[json["language"]],
        shortCode: shortCodeValues.map[json["short_code"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "language_es": languageValues.reverse[languageEs],
        "language": languageValues.reverse[language],
        "short_code": shortCodeValues.reverse[shortCode],
    };
}

enum Language { ES }

final languageValues = EnumValues({
    "es": Language.ES
});

enum ShortCode { PE_CAL, PE, PE_LMA }

final shortCodeValues = EnumValues({
    "pe": ShortCode.PE,
    "PE-CAL": ShortCode.PE_CAL,
    "PE-LMA": ShortCode.PE_LMA
});

class Geometry {
    Geometry({
       required this.coordinates,
       required this.type,
    });

    final List<double> coordinates;
    final String type;

    factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Properties {
    Properties({
      required  this.address,
      required  this.foursquare,
      required  this.wikidata,
       required this.landmark,
      required  this.category,
      required  this.maki,
    });

    final String? address;
    final String? foursquare;
    final String? wikidata;
    final bool? landmark;
    final String? category;
    final String? maki;

    factory Properties.fromRawJson(String str) => Properties.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        address: json["address"],
        foursquare: json["foursquare"],
        wikidata: json["wikidata"],
        landmark: json["landmark"],
        category: json["category"],
        maki: json["maki"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "foursquare": foursquare,
        "wikidata": wikidata,
        "landmark": landmark,
        "category": category,
        "maki": maki,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
}
