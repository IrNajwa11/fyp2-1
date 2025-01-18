// Import the Disease class

final Map<String, Map<String, dynamic>> dinfo = {
  'Corn Cercospora Leaf Spot': {
    'label': 'Corn Cercospora Leaf Spot',
    'type': 'Fungal Disease',
    'causalAgent': 'Cercospora zeae-maydis',
    'symptoms': {
      'Leaves': [
        'Small spots that enlarge with brown streaks',
        'Yellow edges around the spots',
        'Gray or light brown center in older lesions',
        'Lesions with concentric rings'
      ],
      'Stems': [
        'Small dark streaks along the stems',
        'Stunted stem growth'
      ],
      'Vegetable': [
        'Smaller or shriveled kernels in affected ears'
      ],
    },
    'optimumConditions': {
      'Temperature': '25°C - 30°C',
      'Humidity': 'High humidity (70% - 90%)',
      'Soil': 'Well-drained, fertile soil with a neutral pH'
    }
  },
  'Corn Common Rust': {
    'label': 'Corn Common Rust',
    'type': 'Fungal Disease',
    'causalAgent': 'Puccinia sorghi',
    'symptoms': {
      'Leaves': [
        'Rust-colored pustules on the leaves',
        'Yellowing around pustules',
        'Leaf curling in severe cases'
      ],
      'Stems': [
        'Rusty pustules appear on the stems'
      ],
      'Vegetable': [
        'Reduced growth and smaller grain size'
      ],
    },
    'optimumConditions': {
      'Temperature': '20°C - 30°C',
      'Humidity': 'Moderate humidity (60% - 80%)',
      'Soil': 'Well-drained, fertile soil with a slightly acidic to neutral pH'
    }
  },
  'Potato Early Blight': {
    'label': 'Potato Early Blight',
    'type': 'Fungal Disease',
    'causalAgent': 'Alternaria solani',
    'symptoms': {
      'Leaves': [
        'Dark brown spots with concentric rings',
        'Yellowing around lesions',
        'Spots spread from older to younger leaves'
      ],
      'Stems': [
        'Dark lesions near leaf nodes',
        'Weak stems prone to breakage'
      ],
      'Vegetable': [
        'Brown or black lesions on tubers',
        'Rotting or softening of infected tubers'
      ],
    },
    'optimumConditions': {
      'Temperature': '15°C - 25°C',
      'Humidity': 'High humidity (80% - 90%)',
      'Soil': 'Well-drained soil with a slightly acidic pH (5.5 - 6.5)'
    }
  },
  'Potato Late Blight': {
    'label': 'Potato Late Blight',
    'type': 'Fungal Disease',
    'causalAgent': 'Phytophthora infestans',
    'symptoms': {
      'Leaves': [
        'Water-soaked lesions that turn dark brown',
        'Lesions spread from edges to center',
        'White fungal growth on the undersides of leaves'
      ],
      'Stems': [
        'Brown lesions near the soil line',
        'Mushy or rotting stems in high humidity'
      ],
      'Vegetable': [
        'Dark, soft lesions on tubers',
        'Rotting with a foul odor in infected tubers'
      ],
    },
    'optimumConditions': {
      'Temperature': '10°C - 18°C',
      'Humidity': 'High humidity (85% - 100%)',
      'Soil': 'Cool, moist soil with good drainage and slightly acidic pH'
    }
  },
  'Tomato Early Blight': {
    'label': 'Tomato Early Blight',
    'type': 'Fungal Disease',
    'causalAgent': 'Alternaria solani',
    'symptoms': {
      'Leaves': [
        'Dark lesions with concentric rings',
        'Yellowing around spots',
        'Leaves curl and die off, causing early defoliation'
      ],
      'Stems': [
        'Dark lesions on stems, often near leaf nodes',
        'Brittle stems that break easily'
      ],
      'Vegetable': [
        'Small, deformed fruits',
        'Sunscald due to leaf loss'
      ],
    },
    'optimumConditions': {
      'Temperature': '20°C - 27°C',
      'Humidity': 'Moderate to high humidity (60% - 85%)',
      'Soil': 'Well-drained, loamy soil with a slightly acidic pH (5.5 - 6.5)'
    }
  },
  'Tomato Late Blight': {
    'label': 'Tomato Late Blight',
    'type': 'Fungal Disease',
    'causalAgent': 'Phytophthora infestans',
    'symptoms': {
      'Leaves': [
        'Water-soaked lesions that turn dark brown',
        'White fungal growth on leaf undersides',
        'Leaves curl and die off rapidly'
      ],
      'Stems': [
        'Brown lesions on stems near leaf junctions',
        'Mushy stems that collapse under pressure'
      ],
      'Vegetable': [
        'Dark, sunken spots on fruits',
        'Fruits rot quickly as the disease spreads'
      ],
    },
    'optimumConditions': {
      'Temperature': '10°C - 18°C',
      'Humidity': 'High humidity (85% - 100%)',
      'Soil': 'Moist, cool soil with a slightly acidic pH (5.5 - 6.5)'
    }
  },
  'Tomato Yellow Leaf Curl Virus': {
    'label': 'Tomato Yellow Leaf Curl Virus',
    'type': 'Viral Disease',
    'causalAgent': 'Tomato yellow leaf curl virus',
    'symptoms': {
      'Leaves': [
        'Yellowing that starts from the tips and edges',
        'Leaves curl upward or inward',
        'Stunted, compact plant growth'
      ],
      'Stems': [
        'No visible symptoms on the stems'
      ],
      'Vegetable': [
        'Small, deformed fruits',
        'Poor fruit set with uneven ripening'
      ],
    },
    'optimumConditions': {
      'Temperature': '25°C - 30°C',
      'Humidity': 'Low humidity (50% - 70%)',
      'Soil': 'Well-drained, light and fertile soil'
    }
  },
  'Tomato Mosaic Virus': {
    'label': 'Tomato Mosaic Virus',
    'type': 'Viral Disease',
    'causalAgent': 'Tomato mosaic virus',
    'symptoms': {
      'Leaves': [
        'Mosaic pattern of light and dark green areas',
        'Leaf curling and leathery texture',
        'Yellowing and distorted growth'
      ],
      'Stems': [
        'Stems may appear weak with stunted growth'
      ],
      'Vegetable': [
        'Uneven ripening of fruits',
        'Fruits may show yellow streaks'
      ],
    },
    'optimumConditions': {
      'Temperature': '20°C - 28°C',
      'Humidity': 'Moderate humidity (60% - 80%)',
      'Soil': 'Well-drained, fertile soil with a slightly acidic pH'
    }
  },
};