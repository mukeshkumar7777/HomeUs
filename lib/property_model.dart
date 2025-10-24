class Property {
  final String id;
  final String imageAsset; // can be local asset or network URL
  final String title;
  final String location;
  final String price;
  final String? description;
  final List<String> amenities;
  final String contactInfo;
  final String propertyType;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final bool isAvailable;
  final List<String> images;

  const Property({
    required this.id,
    required this.imageAsset,
    required this.title,
    required this.location,
    required this.price,
    this.description,
    this.amenities = const [],
    this.contactInfo = 'Contact us for more details',
    this.propertyType = 'Apartment',
    this.bedrooms = 1,
    this.bathrooms = 1,
    this.area = 0.0,
    this.isAvailable = true,
    this.images = const [],
  });

  factory Property.fromApi(Map<String, dynamic> json) {
    final List images = json['images'] is List ? json['images'] : [];
    final String firstImage = images.isNotEmpty ? images.first as String : '';
    final num p = (json['price'] ?? 0) as num;
    final String city = (json['city'] ?? '').toString();
    return Property(
      id: (json['id'] ?? '').toString(),
      imageAsset: firstImage.isNotEmpty ? firstImage : 'assets/house6.jpg',
      title: (json['title'] ?? 'Property').toString(),
      location: city,
      price: '₹${p.toStringAsFixed(0)}/month',
      description: (json['address'] ?? '').toString(),
      amenities: const [],
      contactInfo: (json['phoneMasked'] ?? '').toString(),
      propertyType: 'Apartment',
      bedrooms: (json['bedrooms'] ?? 0) is num ? (json['bedrooms'] as num).toInt() : 0,
      bathrooms: (json['bathrooms'] ?? 0) is num ? (json['bathrooms'] as num).toInt() : 0,
      area: 0.0,
      isAvailable: (json['isAvailable'] ?? true) == true,
      images: images.map((e) => e.toString()).toList(),
    );
  }

  // Sample properties data
  static const List<Property> sampleProperties = [
    Property(
      id: '1',
      imageAsset: 'assets/2bhk.jpg',
      title: '2BHK Apartment',
      location: 'Hyderabad',
      price: '₹12,000/month',
      description: 'Beautiful 2BHK apartment in the heart of Hyderabad with modern amenities and excellent connectivity.',
      amenities: ['WiFi', 'Parking', 'Security', 'Gym', 'Lift', 'Power Backup'],
      contactInfo: '+91 98765 43210',
      propertyType: 'Apartment',
      bedrooms: 2,
      bathrooms: 2,
      area: 1200.0,
      images: ['assets/2bhk.jpg', 'assets/house1.jpg', 'assets/house2.jpg'],
    ),
    Property(
      id: '2',
      imageAsset: 'assets/house7.jpg',
      title: 'Villa with Garden',
      location: 'Bangalore',
      price: '₹25,000/month',
      description: 'Spacious villa with a beautiful garden, perfect for families looking for a peaceful environment.',
      amenities: ['WiFi', 'Parking', 'Security', 'Garden', 'Swimming Pool', 'Power Backup'],
      contactInfo: '+91 98765 43211',
      propertyType: 'Villa',
      bedrooms: 3,
      bathrooms: 3,
      area: 2000.0,
      images: ['assets/house7.jpg', 'assets/house3.jpg', 'assets/house5.jpg'],
    ),
    Property(
      id: '3',
      imageAsset: 'assets/hostel1.jpg',
      title: 'PG Accommodation',
      location: 'Mumbai',
      price: '₹8,000/month',
      description: 'Comfortable PG accommodation with all basic amenities, ideal for students and working professionals.',
      amenities: ['WiFi', 'Meals', 'Laundry', 'Security', 'Common Area'],
      contactInfo: '+91 98765 43212',
      propertyType: 'PG',
      bedrooms: 1,
      bathrooms: 1,
      area: 300.0,
      images: ['assets/hostel1.jpg', 'assets/pg2.jpg', 'assets/pgs.jpg'],
    ),
    Property(
      id: '4',
      imageAsset: 'assets/house5.jpg',
      title: '1BHK Studio',
      location: 'Delhi',
      price: '₹15,000/month',
      description: 'Modern 1BHK studio apartment with contemporary design and all modern facilities.',
      amenities: ['WiFi', 'Parking', 'Security', 'Lift', 'Power Backup', 'Water Supply'],
      contactInfo: '+91 98765 43213',
      propertyType: 'Studio',
      bedrooms: 1,
      bathrooms: 1,
      area: 600.0,
      images: ['assets/house5.jpg', 'assets/house6.jpg'],
    ),
  ];
}
