import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_ecommerce_app/src/models/product_model.dart';
import 'package:frontend_ecommerce_app/src/repository/porduct_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  test('test get products', () async {
    final repository = ProductRepository();
    List<Product> result = await repository.getProducts();

    expect(result, isList);
    print('value length :  ${result.length}');
    expect(result.isEmpty, false);
    // expect(result[0], isA<Product>());
  });
}
