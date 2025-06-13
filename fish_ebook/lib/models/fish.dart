class Fish {
  final int id;
  final String nameZh;
  final String nameEn;
  final String habitat;
  final String description;
  final String imageAsset;

  const Fish({
    required this.id,
    required this.nameZh,
    required this.nameEn,
    required this.habitat,
    required this.description,
    required this.imageAsset,
  });
}

const List<Fish> fishList = [
  Fish(
    id: 1,
    nameZh: '小丑魚',
    nameEn: 'Clownfish (Amphiprioninae)',
    habitat: '熱帶珊瑚礁',
    description: '以其鮮豔的橘白相間條紋聞名，與海葵共生。',
    imageAsset: 'assets/images/clownfish.jfif',
  ),
  Fish(
    id: 2,
    nameZh: '藍刺尾魚',
    nameEn: 'Blue Tang (Paracanthurus hepatus)',
    habitat: '印度-太平洋珊瑚礁',
    description: '又稱「多莉魚」，體型扁平，鮮藍色帶黑邊。',
    imageAsset: 'assets/images/blue_tang.jfif',
  ),
  Fish(
    id: 3,
    nameZh: '海洋天使魚',
    nameEn: 'Angelfish (Pomacanthidae)',
    habitat: '熱帶淺海',
    description: '體色絢麗，多樣化斑紋，常見於水族箱。',
    imageAsset: 'assets/images/angelfish.jfif',
  ),
  Fish(
    id: 4,
    nameZh: '孔雀魚',
    nameEn: 'Guppy (Poecilia reticulata)',
    habitat: '淡水溫帶地區',
    description: '小型淡水魚，繁殖力強，顏色繁多。',
    imageAsset: 'assets/images/guppy.jpg',
  ),
  Fish(
    id: 5,
    nameZh: '鮭魚',
    nameEn: 'Salmon (Salmonidae)',
    habitat: '常見於餐桌',
    description: '肉質鮮美，營養豐富。',
    imageAsset: 'assets/images/salmon.jpg',
  ),
];