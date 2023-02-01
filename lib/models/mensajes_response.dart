// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromMap(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromMap(String str) =>
    MensajesResponse.fromMap(json.decode(str));

String mensajesResponseToMap(MensajesResponse data) =>
    json.encode(data.toMap());

class MensajesResponse {
  MensajesResponse({
    required this.ok,
    required this.mensaje,
  });

  bool ok;
  List<Mensaje> mensaje;

  factory MensajesResponse.fromMap(Map<String, dynamic> json) =>
      MensajesResponse(
        ok: json["ok"],
        mensaje:
            List<Mensaje>.from(json["mensaje"].map((x) => Mensaje.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "mensaje": List<dynamic>.from(mensaje.map((x) => x.toMap())),
      };
}

class Mensaje {
  Mensaje({
    required this.de,
    required this.para,
    required this.mensaje,
    required this.createdAt,
    required this.updatedAt,
  });

  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;

  factory Mensaje.fromMap(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
