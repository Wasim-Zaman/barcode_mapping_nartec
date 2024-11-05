class MemberLoginResponseModel {
  final bool success;
  final MemberData memberData;
  final String token;

  MemberLoginResponseModel({
    required this.success,
    required this.memberData,
    required this.token,
  });

  factory MemberLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return MemberLoginResponseModel(
      success: json['success'] ?? false,
      memberData: MemberData.fromJson(json['memberData'] ?? {}),
      token: json['token'] ?? '',
    );
  }
}

class MemberData {
  final String id;
  final String? userType;
  final String email;
  final String mobile;
  final String? companyId;
  final String crNumber;
  final String crActivity;
  final String companyNameEng;
  final String companyNameArabic;
  final String contactPerson;
  final String companyLandLine;
  final String status;
  final int paymentStatus;
  final String transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String gcpGLNID;
  final String gln;
  final DateTime? gcpExpiry;
  final String memberId;
  final String remarks;
  final String assignTo;
  final String membershipCategory;
  final double upgradationDisc;
  final double upgradationDiscAmount;
  final double renewalDisc;
  final double renewalDiscAmount;
  final String city;
  final String country;
  final String state;
  final String zipCode;
  final List<IndustryType> industryTypes;
  final int isproductApproved;
  final String memberType;
  final int gepirPosted;
  final String apiKey;
  final String gpsLocation;
  final double latitude;
  final double longitude;
  final String userSource;
  final List<Cart> carts;
  final String parentMemberUniqueID;

  MemberData({
    required this.id,
    this.userType,
    required this.email,
    required this.mobile,
    this.companyId,
    required this.crNumber,
    required this.crActivity,
    required this.companyNameEng,
    required this.companyNameArabic,
    required this.contactPerson,
    required this.companyLandLine,
    required this.status,
    required this.paymentStatus,
    required this.transactionId,
    required this.createdAt,
    required this.updatedAt,
    required this.gcpGLNID,
    required this.gln,
    this.gcpExpiry,
    required this.memberId,
    required this.remarks,
    required this.assignTo,
    required this.membershipCategory,
    required this.upgradationDisc,
    required this.upgradationDiscAmount,
    required this.renewalDisc,
    required this.renewalDiscAmount,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
    required this.industryTypes,
    required this.isproductApproved,
    required this.memberType,
    required this.gepirPosted,
    required this.apiKey,
    required this.gpsLocation,
    required this.latitude,
    required this.longitude,
    required this.userSource,
    required this.carts,
    required this.parentMemberUniqueID,
  });

  factory MemberData.fromJson(Map<String, dynamic> json) {
    return MemberData(
      id: json['id'] ?? '',
      userType: json['user_type'],
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      companyId: json['companyID']?.toString(),
      crNumber: json['cr_number'] ?? '',
      crActivity: json['cr_activity'] ?? '',
      companyNameEng: json['company_name_eng'] ?? '',
      companyNameArabic: json['company_name_arabic'] ?? '',
      contactPerson: json['contactPerson'] ?? '',
      companyLandLine: json['companyLandLine'] ?? '',
      status: json['status'] ?? '',
      paymentStatus: json['payment_status'] ?? 0,
      transactionId: json['transaction_id'] ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      gcpGLNID: json['gcpGLNID']?.toString() ?? '',
      gln: json['gln']?.toString() ?? '',
      gcpExpiry: json['gcp_expiry'] != null
          ? DateTime.parse(json['gcp_expiry'])
          : null,
      memberId: json['memberID']?.toString() ?? '',
      remarks: json['remarks'] ?? '',
      assignTo: json['assign_to'] ?? '',
      membershipCategory: json['membership_category'] ?? '',
      upgradationDisc: (json['upgradation_disc'] ?? 0).toDouble(),
      upgradationDiscAmount: (json['upgradation_disc_amount'] ?? 0).toDouble(),
      renewalDisc: (json['renewal_disc'] ?? 0).toDouble(),
      renewalDiscAmount: (json['renewal_disc_amount'] ?? 0).toDouble(),
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zip_code']?.toString() ?? '',
      industryTypes: (json['industryTypes'] as List? ?? [])
          .map((type) => IndustryType.fromJson(type))
          .toList(),
      isproductApproved: json['isproductApproved'] ?? 0,
      memberType: json['member_type'] ?? '',
      gepirPosted: json['gepirPosted'] ?? 0,
      apiKey: json['api_key'] ?? '',
      gpsLocation: json['gps_location'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: json['longitude'] ?? 0,
      userSource: json['user_source'] ?? '',
      carts: (json['carts'] as List? ?? [])
          .map((cart) => Cart.fromJson(cart))
          .toList(),
      parentMemberUniqueID: json['parentMemberUniqueID'] ?? '',
    );
  }
}

class IndustryType {
  final String id;
  final String name;

  IndustryType({
    required this.id,
    required this.name,
  });

  factory IndustryType.fromJson(Map<String, dynamic> json) {
    return IndustryType(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Cart {
  final String id;
  final String transactionId;
  final List<CartItem> cartItems;
  final String? documents;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double discount;

  Cart({
    required this.id,
    required this.transactionId,
    required this.cartItems,
    this.documents,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.discount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] ?? '',
      transactionId: json['transaction_id']?.toString() ?? '',
      cartItems: (json['cart_items'] as List? ?? [])
          .map((item) => CartItem.fromJson(item))
          .toList(),
      documents: json['documents'],
      userId: json['user_id'] ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      discount: (json['discount'] ?? 0).toDouble(),
    );
  }
}

class CartItem {
  final String productId;
  final String productName;
  final String registrationFee;
  final String yearlyFee;
  final String price;
  final String productType;

  CartItem({
    required this.productId,
    required this.productName,
    required this.registrationFee,
    required this.yearlyFee,
    required this.price,
    required this.productType,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productID']?.toString() ?? '',
      productName: json['productName'] ?? '',
      registrationFee: json['registration_fee']?.toString() ?? '',
      yearlyFee: json['yearly_fee']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      productType: json['product_type'] ?? '',
    );
  }
}
