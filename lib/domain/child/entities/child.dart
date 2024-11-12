class Child {
  final String id;
  final String? foundationId;
  final String? name;
  final String? lastName;
  final String? personalId;
  final String? birthDate;
  final Responsible responsible;
  final FoundationHistory history;

  Child({
    required this.id,
    this.foundationId,
    this.name,
    this.lastName,
    this.personalId,
    this.birthDate,
    required this.responsible,
    required this.history,
  });

  Child copyWith({
    String? foundationId,
    String? name,
    String? lastName,
    String? personalId,
    String? birthDate,
    Responsible? responsible,
    FoundationHistory? history,

  }) {
    return Child(
      id: id,
      foundationId: foundationId ?? this.foundationId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      personalId: personalId ?? this.personalId,
      birthDate: birthDate ?? this.birthDate,
      responsible: responsible ?? this.responsible,
      history: history ?? this.history,
    );
  }
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
}

class FoundationHistory {
  final String? courtId;
  final String? entryDate;
  final String? reentryDate;
  final String? departureDate;
  final List<String>? entryReason;
  final String? departureReason;
  final String? organization;


  FoundationHistory({
    this.courtId,
    this.entryDate,
    this.reentryDate,
    this.departureDate,
    this.entryReason,
    this.departureReason,
    this.organization,
  });

}