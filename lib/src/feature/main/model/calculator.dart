class Calculator {
  final int days;
  final int people;
  final String place;

  Calculator({
    required this.days,
    required this.people,
    required this.place,
  });

  /// Calculates the survival needs in a more realistic way:
  /// 1) Total water in milliliters needed for all people across all days
  ///    with environment multipliers.
  /// 2) Total food in calories needed for all people across all days,
  ///    also considering environmental factors.
  /// 3) A recommended list of items from a pool of 60 possible items,
  ///    with some additional items if the place is particularly hot, cold, etc.
  Map<String, dynamic> calculateSurvivalNeeds() {
    // Base daily consumption assumptions per person (moderately realistic):
    // - Water: 3000 ml (3 liters) per day
    // - Food: ~2000 calories per day

    // Define some environment multipliers for water and food.
    // These are example values to illustrate "realistic" variation.
    // In actual use, you'd refine these based on research or experience.
    double waterMultiplier;
    double foodMultiplier;

    if (place.toLowerCase().contains('desert')) {
      // Higher water requirement, normal food
      waterMultiplier = 1.5;
      foodMultiplier = 1.0;
    } else if (place.toLowerCase().contains('arctic') ||
        place.toLowerCase().contains('tundra') ||
        place.toLowerCase().contains('snow')) {
      // More food for heat generation, slightly more water
      waterMultiplier = 1.2;
      foodMultiplier = 1.3;
    } else if (place.toLowerCase().contains('jungle') ||
        place.toLowerCase().contains('tropical')) {
      // Slightly more water due to humidity and sweating, a bit more food
      waterMultiplier = 1.2;
      foodMultiplier = 1.1;
    } else if (place.toLowerCase().contains('mountain') ||
        place.toLowerCase().contains('alpine')) {
      // More calories for elevation, slightly more water
      waterMultiplier = 1.1;
      foodMultiplier = 1.2;
    } else {
      // Default for moderate climates (forest, urban, etc.)
      waterMultiplier = 1.0;
      foodMultiplier = 1.0;
    }

    // Calculate the total water and food requirements
    final double baseWaterPerPerson = 3000; // ml per day
    final double baseFoodPerPerson = 2000;  // calories per day

    final int totalWaterMl = (baseWaterPerPerson * days * people * waterMultiplier).round();
    final int totalFoodCalories = (baseFoodPerPerson * days * people * foodMultiplier).round();

    // Select items:
    // We always include some universal items, but also choose environment-specific gear if needed.
    List<String> universalItems = _universalItems();
    List<String> recommended = List<String>.from(universalItems);

    // Add or emphasize some items based on environment
    if (place.toLowerCase().contains('desert')) {
      recommended.add('Extra Water Containers');
      recommended.add('Lightweight Clothing');
      recommended.add('Wide-Brim Hat');
    } else if (place.toLowerCase().contains('arctic') ||
        place.toLowerCase().contains('tundra') ||
        place.toLowerCase().contains('snow')) {
      recommended.add('Thermal Clothing');
      recommended.add('Insulated Boots');
      recommended.add('Hand Warmers');
    } else if (place.toLowerCase().contains('jungle') ||
        place.toLowerCase().contains('tropical')) {
      recommended.add('Mosquito Netting');
      recommended.add('Extra Insect Repellent');
      recommended.add('Breathable Clothing');
    } else if (place.toLowerCase().contains('mountain') ||
        place.toLowerCase().contains('alpine')) {
      recommended.add('Climbing Gear');
      recommended.add('Warm Layers');
      recommended.add('Sturdy Hiking Boots');
    }

    // Remove duplicates in case we added the same item more than once
    final uniqueRecommended = recommended.toSet().toList();

    // Return results
    return {
      'waterMl': totalWaterMl,
      'foodCalories': totalFoodCalories,
      'items': uniqueRecommended,
    };
  }

  /// A pool of 60 possible items (universal + environment-agnostic).
  /// In real usage, you might select from this list more dynamically
  /// based on days, people, or place. For now, it remains for reference.
  List<String> _items() {
    return [
      'Hunting Knife',
      'Crowbar',
      'First Aid Kit',
      'Antibiotic Ointment',
      'Water Filter',
      'Water Purification Tablets',
      'Sleeping Bag',
      'Tarp',
      'Tent',
      'Rope (50 ft)',
      'Duct Tape',
      'Ferro Rod (Firestarter)',
      'Matches',
      'Lighter',
      'Flashlight',
      'Headlamp',
      'Extra Batteries',
      'Compass',
      'Paper Map',
      'GPS Device',
      'Rain Poncho',
      'Insulated Jacket',
      'Thermal Gloves',
      'Wool Beanie',
      'Cooking Pot',
      'Metal Cup',
      'Spork',
      'Canned Food',
      'Dried Fruits',
      'Energy Bars',
      'Trail Mix',
      'Multi-Tool',
      'Whistle',
      'Signal Mirror',
      'Sunscreen',
      'Insect Repellent',
      'Knife Sharpener',
      'Fishing Kit',
      'Paracord',
      'Hand Sanitizer',
      'Biodegradable Soap',
      'Small Towel',
      'Folding Shovel',
      'Survival Blanket',
      'Signal Flare',
      'Carabiners',
      'Hammer',
      'Folding Saw',
      'Axe',
      'Snare Wire',
      'Binoculars',
      'Sunglasses',
      'Water Container',
      'Chlorine Drops',
      'Fire Extinguisher',
      'Notebook',
      'Pencil',
      'Pepper Spray',
      'Warm Socks'
    ];
  }

  /// A smaller subset of 'universal items' typically recommended for any environment.
  /// Pulled from the full 60-item list.
  List<String> _universalItems() {
    // In a real scenario, this list might come from the 60 above,
    // but here is a quick subset for demonstration:
    return [
      'First Aid Kit',
      'Hunting Knife',
      'Water Filter',
      'Sleeping Bag',
      'Tent',
      'Ferro Rod (Firestarter)',
      'Lighter',
      'Flashlight',
      'Extra Batteries',
      'Compass',
      'Paper Map',
      'Duct Tape',
      'Rope (50 ft)',
      'Cooking Pot',
      'Multi-Tool',
      'Insect Repellent',
      'Notebook',
      'Pencil',
    ];
  }

  /// A predefined list of 20 places in English for demonstration or reference.
  /// You can use these if you want to check user input or display place options.
  static List<String> places() {
    return [
      'Forest',
      'Desert',
      'Jungle',
      'Mountains',
      'Urban Ruins',
      'Arctic Tundra',
      'Savanna',
      'Coastal Beach',
      'Swamp',
      'Rainforest',
      'Canyon',
      'Prairie',
      'Cave System',
      'Island',
      'Alpine Region',
      'River Delta',
      'Volcano Slope',
      'Grassland',
      'Mangrove',
      'Bamboo Forest',
    ];
  }
}
