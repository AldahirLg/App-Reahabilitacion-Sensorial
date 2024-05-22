import 'dart:math';

double _doubleInRnage(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;
final random = Random();
final devices = List.generate(
    _names.length,
    (index) => Device(
        name: _names[index],
        image: 'assets/images/${index + 1}.png',
        price: _doubleInRnage(random, 3, 7)));

class Device {
  Device({
    required this.name,
    required this.image,
    required this.price,
  });

  final String name;
  final String image;
  final double price; // Agrega esta línea para definir la propiedad "price"
}

final _names = [
  'Tubo de Burbujas uno',
  'Proyector de Luz uno',
  'Tubo de Burbujas Dos',
  'Proyector de Luz dos',
];
