class Child {
  final String? id;
  final String? foundationId;
  final String? name;
  final String? lastName;
  final String? personalId;
  final String? birthCertificate;
  final Responsible responsible;
  final FoundationHistory history;

  Child({
    this.id,
    this.foundationId,
    this.name,
    this.lastName,
    this.personalId,
    this.birthCertificate,
    required this.responsible,
    required this.history,
  });

  Child copyWith({
    String? id,
    String? foundationId,
    String? name,
    String? lastName,
    String? personalId,
    String? birthCertificate,
    Responsible? responsible,
    FoundationHistory? history,

  }) {
    return Child(
      id: id?? this.id,
      foundationId: foundationId ?? this.foundationId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      personalId: personalId ?? this.personalId,
      birthCertificate: birthCertificate ?? this.birthCertificate,
      responsible: responsible ?? this.responsible,
      history: history ?? this.history,
    );
  }

  static Child manyFromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] as String?,
      foundationId: json['internal_id'] as String?,
      name: json['names'] as String?,
      lastName: json['last_names'] as String?,
      personalId: json['identification']['personal_id'] as String?,
      birthCertificate: json['identification']['birth_certificate'] as String?,
      responsible: Responsible(),
      history: FoundationHistory(),
    );
  }

  static Child oneFromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] as String,
      foundationId: json['kid']['internal_id'] as String?,
      name: json['kid']['names'] as String?,
      lastName: json['kid']['last_names'] as String?,
      personalId: json['kid']['identification']['personal_id'] as String?,
      birthCertificate: json['kid']['identification']['birth_certificate'] as String?,
      responsible: Responsible(
        names: (json['responsibles']['names'] as List<dynamic>?)?.map((e) => e?.toString() ?? 'No Info').toList() ?? [],
        docsId: (json['responsibles']['identifications'] as List<dynamic>?)?.map((e) => e?.toString() ?? 'No Info').toList() ?? [],
        contactNro: (json['responsibles']['contacts'] as List<dynamic>?)?.map((e) => e?.toString() ?? 'No Info').toList() ?? [],
      ),
      history: FoundationHistory(
        courtId: json['record']['court_id'] as String?,
        entryDate: (json['record']['bambi_entry_dates'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        entryReason: (json['record']['bambi_entry_reasons'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        departureDate: (json['record']['bambi_departure_date'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        departureReason: json['record']['bambi_departure_reason'] as String?,
        organization: json['record']['justice_organization'] as String?,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "kid_internal_id": foundationId,
        "kid_names": name,
        "kid_last_names": lastName,
        "kid_personal_id": personalId,
        "kid_birth_certificate": birthCertificate,
        "record_court_id": history.courtId,
        "record_bambi_entry_date": List<String>.from(history.entryDate.map((x) => x)),
        "record_bambi_entry_reasons": List<String>.from(history.entryReason.map((x) => x)),
        "record_bambi_departure_date": List<String>.from(history.departureDate.map((x) => x)),
        "record_bambi_departure_reason": List<String>.from(history.departureDate),
        "record_justice_organization": history.organization,
        "responsible_names": List<String>.from(responsible.names?.map((x) => x) ?? []),
        "responsible_identification": List<String>.from(responsible.docsId?.map((x) => x) ?? []),
        "responsible_contact": List<String>.from(responsible.contactNro?.map((x) => x) ?? []),
  };
}

class Responsible {
  final List<String>? names;
  final List<String>?docsId;
  final List<String>? contactNro;

  Responsible({
    this.names,
    this.docsId,
    this.contactNro,
  });

  Responsible copyWith({
    List<String>? names,
    List<String>? docsId,
    List<String>? contactNro,
  }) {
    return Responsible(
      names: names ?? this.names,
      docsId: docsId ?? this.docsId,
      contactNro: contactNro ?? this.contactNro,
    );
  }
}

class FoundationHistory {
  final String? courtId;
  final List<String> entryDate;
  final List<String> departureDate;
  final List<String> entryReason;
  final String? departureReason;
  final String? organization;


  FoundationHistory({
    this.courtId,
    this.entryDate = const [],
    this.departureDate = const [],
    this.entryReason = const [],
    this.departureReason,
    this.organization,
  });

  FoundationHistory copyWith({
    String? courtId,
    List<String>? entryDate,
    List<String>? departureDate,
    List<String>? entryReason,
    String? departureReason,
    String? organization,
  }) {
    return FoundationHistory(
      courtId: courtId ?? this.courtId,
      entryDate: entryDate ?? this.entryDate,
      departureDate: departureDate ?? this.departureDate,
      entryReason: entryReason ?? this.entryReason,
      departureReason: departureReason ?? this.departureReason,
      organization: organization ?? this.organization,
    );
  }

}