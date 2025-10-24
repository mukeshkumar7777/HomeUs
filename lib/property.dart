class Property {
  final String id;
  final String title;
  final String location;
  final String description;
  final double price;
  final String type;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final List<String> images;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.images = const [],
  });

  static List<Property> get sampleProperties => [
    Property(
      id: '1',
      title: 'Modern Apartment Downtown',
      location: 'New York, NY',
      description: 'Beautiful modern apartment in the heart of downtown',
      price: 2500,
      type: 'rent',
      bedrooms: 2,
      bathrooms: 2,
      area: 1200,
    ),
    Property(
      id: '2',
      title: 'Family House with Garden',
      location: 'Los Angeles, CA',
      description: 'Spacious family house with beautiful garden',
      price: 450000,
      type: 'sale',
      bedrooms: 4,
      bathrooms: 3,
      area: 2500,
    ),
    Property(
      id: '3',
      title: 'Luxury Penthouse',
      location: 'Miami, FL',
      description: 'Stunning penthouse with ocean view',
      price: 1200000,
      type: 'sale',
      bedrooms: 3,
      bathrooms: 3,
      area: 3000,
    ),
    Property(
      id: '4',
      title: 'Cozy Studio Apartment',
      location: 'Seattle, WA',
      description: 'Perfect studio for young professionals',
      price: 1800,
      type: 'rent',
      bedrooms: 1,
      bathrooms: 1,
      area: 600,
    ),
    Property(
      id: '5',
      title: 'Commercial Office Space',
      location: 'Chicago, IL',
      description: 'Prime office space in business district',
      price: 5000,
      type: 'commercial',
      bedrooms: 0,
      bathrooms: 2,
      area: 2000,
    ),
    Property(
      id: '6',
      title: 'Vacation Rental Beach House',
      location: 'San Diego, CA',
      description: 'Beautiful beach house perfect for vacation',
      price: 300,
      type: 'rent',
      bedrooms: 3,
      bathrooms: 2,
      area: 1800,
    ),
  ];
}