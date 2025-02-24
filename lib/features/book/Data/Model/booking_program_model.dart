

class BookingProgramModel {
  final int programId;
  final String? note;
  final String? address;
  final String? healthStatus;
  final String? nationality;
  final String? parentAddress;
  final String? parentName;
  final String? parentNationality;
  final String? phoneNumber;
  // final MultipartFile? image;

  BookingProgramModel({
    required this.programId,
    this.note,
    this.address,
    this.healthStatus,
    this.nationality,
    this.parentAddress,
    this.parentName,
    this.parentNationality,
    this.phoneNumber,
    // this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'programId': programId,
      'note': note,
      'address': address,
      'healthStatus': healthStatus,
      'nationality': nationality,
      'parentAddress': parentAddress,
      'parentName': parentName,
      'parentNationality': parentNationality,
      'phoneNumber': phoneNumber,
      // 'image': image
    };
  }

  // Add a copyWith method
  BookingProgramModel copyWith({
    int? programId,
    String? note,
    String? address,
    String? healthStatus,
    String? nationality,
    String? parentAddress,
    String? parentName,
    String? parentNationality,
    String? phoneNumber,
    // String? image
  }) {
    return BookingProgramModel(
      programId: programId ?? this.programId,
      note: note ?? this.note,
      address: address ?? this.address,
      healthStatus: healthStatus ?? this.healthStatus,
      nationality: nationality ?? this.nationality,
      parentAddress: parentAddress ?? this.parentAddress,
      parentName: parentName ?? this.parentName,
      parentNationality: parentNationality ?? this.parentNationality,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      
    );
  }
}
