import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart.dart';

void main() {
  group('CartItem', () {
    test('should create a cart item with default values', () {
      final item = CartItem(id: '1', name: 'Test Product', price: 99.99);

      expect(item.id, '1');
      expect(item.name, 'Test Product');
      expect(item.price, 99.99);
      expect(item.quantity, 1);
      expect(item.discount, 0.0);
    });

    test('should create a cart item with custom values', () {
      final item = CartItem(
        id: '2',
        name: 'Discounted Product',
        price: 199.99,
        quantity: 3,
        discount: 0.15,
      );

      expect(item.id, '2');
      expect(item.name, 'Discounted Product');
      expect(item.price, 199.99);
      expect(item.quantity, 3);
      expect(item.discount, 0.15);
    });

    test('should allow quantity modification', () {
      final item = CartItem(id: '1', name: 'Test Product', price: 99.99);

      item.quantity = 5;
      expect(item.quantity, 5);
    });
  });

  group('ShoppingCartLogic - Add Item Operations', () {
    test('should add a new item to the cart', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);

      expect(cart.items.length, 1);
      expect(cart.items[0].id, '1');
      expect(cart.items[0].name, 'iPhone');
      expect(cart.items[0].price, 999.99);
      expect(cart.items[0].quantity, 1);
    });

    test('should update quantity when adding duplicate item', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99, discount: 0.1);
      cart.addItem('1', 'iPhone', 999.99, discount: 0.1);

      expect(
        cart.items.length,
        1,
        reason: 'Should not create duplicate entries',
      );
      expect(
        cart.items[0].quantity,
        2,
        reason: 'Quantity should be incremented',
      );
    });

    test('should handle multiple duplicate additions', () {
      final cart = ShoppingCartLogic();

      for (int i = 0; i < 5; i++) {
        cart.addItem('1', 'iPhone', 999.99);
      }

      expect(cart.items.length, 1);
      expect(cart.items[0].quantity, 5);
    });

    test('should add different items separately', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);
      cart.addItem('2', 'Galaxy', 899.99);
      cart.addItem('3', 'iPad', 1099.99);

      expect(cart.items.length, 3);
      expect(cart.items[0].id, '1');
      expect(cart.items[1].id, '2');
      expect(cart.items[2].id, '3');
    });

    test('should preserve discount when adding duplicate items', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99, discount: 0.2);
      cart.addItem('1', 'iPhone', 999.99, discount: 0.2);

      expect(cart.items[0].discount, 0.2);
      expect(cart.items[0].quantity, 2);
    });
  });

  group('ShoppingCartLogic - Remove Item Operations', () {
    test('should remove an item from the cart', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);
      cart.addItem('2', 'Galaxy', 899.99);

      cart.removeItem('1');

      expect(cart.items.length, 1);
      expect(cart.items[0].id, '2');
    });

    test('should handle removing non-existent item', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);

      cart.removeItem('999');

      expect(cart.items.length, 1);
    });

    test('should remove all instances of an item', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);
      cart.addItem('1', 'iPhone', 999.99);
      cart.addItem('1', 'iPhone', 999.99);

      cart.removeItem('1');

      expect(cart.items.length, 0);
    });
  });

  group('ShoppingCartLogic - Update Quantity Operations', () {
    test('should update item quantity', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);

      cart.updateQuantity('1', 5);

      expect(cart.items[0].quantity, 5);
    });

    test('should remove item when quantity is 0', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);

      cart.updateQuantity('1', 0);

      expect(cart.items.length, 0);
    });

    test('should remove item when quantity is negative', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);

      cart.updateQuantity('1', -5);

      expect(cart.items.length, 0);
    });

    test('should handle updating non-existent item', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);

      cart.updateQuantity('999', 10);

      expect(cart.items.length, 1);
      expect(cart.items[0].quantity, 1);
    });

    test('should handle large quantity values', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);

      cart.updateQuantity('1', 1000);

      expect(cart.items[0].quantity, 1000);
    });
  });

  group('ShoppingCartLogic - Clear Cart Operations', () {
    test('should clear all items from cart', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);
      cart.addItem('2', 'Galaxy', 899.99);
      cart.addItem('3', 'iPad', 1099.99);

      cart.clearCart();

      expect(cart.items.length, 0);
    });

    test('should handle clearing empty cart', () {
      final cart = ShoppingCartLogic();

      cart.clearCart();

      expect(cart.items.length, 0);
    });
  });

  group('ShoppingCartLogic - Subtotal Calculations', () {
    test('should calculate subtotal correctly', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);
      cart.addItem('2', 'Galaxy', 899.99);

      expect(cart.subtotal, closeTo(1899.98, 0.01));
    });

    test('should include quantity in subtotal', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 100.0);
      cart.updateQuantity('1', 3);

      expect(cart.subtotal, 300.0);
    });

    test('should return 0 for empty cart', () {
      final cart = ShoppingCartLogic();

      expect(cart.subtotal, 0.0);
    });

    test('should handle multiple items with different quantities', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Item A', 50.0);
      cart.updateQuantity('1', 2);
      cart.addItem('2', 'Item B', 75.0);
      cart.updateQuantity('2', 3);

      // 50*2 + 75*3 = 100 + 225 = 325
      expect(cart.subtotal, 325.0);
    });
  });

  group('ShoppingCartLogic - Discount Calculations', () {
    test('should calculate discount correctly', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 1000.0, discount: 0.1); // 10% discount

      expect(cart.totalDiscount, closeTo(100.0, 0.01));
    });

    test('should calculate discount with quantity', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 1000.0, discount: 0.1);
      cart.updateQuantity('1', 3);

      // 1000 * 3 * 0.1 = 300
      expect(cart.totalDiscount, closeTo(300.0, 0.01));
    });

    test('should sum discounts from multiple items', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 1000.0, discount: 0.1); // 100 discount
      cart.addItem('2', 'Galaxy', 800.0, discount: 0.15); // 120 discount

      expect(cart.totalDiscount, closeTo(220.0, 0.01));
    });

    test('should return 0 for items without discount', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 1000.0);

      expect(cart.totalDiscount, 0.0);
    });

    test('should handle 100% discount', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Free Item', 500.0, discount: 1.0);

      expect(cart.totalDiscount, 500.0);
    });

    test('should handle 50% discount correctly', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Half Price', 200.0, discount: 0.5);

      expect(cart.totalDiscount, 100.0);
    });
  });

  group('ShoppingCartLogic - Total Amount Calculations', () {
    test('should calculate total amount correctly', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 1000.0, discount: 0.1);

      // Subtotal: 1000, Discount: 100, Total: 900
      expect(cart.totalAmount, closeTo(900.0, 0.01));
    });

    test('should calculate total with multiple items', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 1000.0, discount: 0.1); // 1000 - 100 = 900
      cart.addItem('2', 'Galaxy', 800.0, discount: 0.2); // 800 - 160 = 640

      // Total: 1800 - 260 = 1540
      expect(cart.totalAmount, closeTo(1540.0, 0.01));
    });

    test('should calculate total without discount', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 1000.0);

      expect(cart.totalAmount, 1000.0);
    });

    test('should return 0 for empty cart', () {
      final cart = ShoppingCartLogic();

      expect(cart.totalAmount, 0.0);
    });

    test('should handle 100% discount total', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Free Item', 500.0, discount: 1.0);

      expect(cart.totalAmount, 0.0);
    });

    test('should calculate complex cart total', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99, discount: 0.1);
      cart.updateQuantity('1', 2);
      cart.addItem('2', 'Galaxy', 899.99, discount: 0.15);
      cart.addItem('3', 'iPad', 1099.99);

      // iPhone: 999.99 * 2 = 1999.98, discount: 199.998
      // Galaxy: 899.99, discount: 134.9985
      // iPad: 1099.99, discount: 0
      // Subtotal: 3999.96
      // Total Discount: 334.9965
      // Total: 3664.9635
      expect(cart.totalAmount, closeTo(3664.96, 0.01));
    });
  });

  group('ShoppingCartLogic - Total Items Count', () {
    test('should count total items', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);
      cart.addItem('2', 'Galaxy', 899.99);

      expect(cart.totalItems, 2);
    });

    test('should count items with quantities', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'iPhone', 999.99);
      cart.updateQuantity('1', 5);
      cart.addItem('2', 'Galaxy', 899.99);
      cart.updateQuantity('2', 3);

      expect(cart.totalItems, 8);
    });

    test('should return 0 for empty cart', () {
      final cart = ShoppingCartLogic();

      expect(cart.totalItems, 0);
    });
  });

  group('ShoppingCartLogic - Edge Cases', () {
    test('should handle empty cart operations', () {
      final cart = ShoppingCartLogic();

      expect(cart.items.length, 0);
      expect(cart.subtotal, 0.0);
      expect(cart.totalDiscount, 0.0);
      expect(cart.totalAmount, 0.0);
      expect(cart.totalItems, 0);
    });

    test('should handle very small prices', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Penny Item', 0.01);

      expect(cart.subtotal, closeTo(0.01, 0.001));
    });

    test('should handle very large prices', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Expensive Item', 999999.99);

      expect(cart.subtotal, 999999.99);
    });

    test('should handle zero price items', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Free Item', 0.0);

      expect(cart.subtotal, 0.0);
      expect(cart.totalAmount, 0.0);
    });

    test('should handle maximum quantity values', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Item', 10.0);
      cart.updateQuantity('1', 999999);

      expect(cart.items[0].quantity, 999999);
      expect(cart.subtotal, 9999990.0);
    });

    test('should handle near-100% discount', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Almost Free', 1000.0, discount: 0.99);

      expect(cart.totalDiscount, closeTo(990.0, 0.01));
      expect(cart.totalAmount, closeTo(10.0, 0.01));
    });

    test('should handle mixed discounts and no discounts', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Discounted', 100.0, discount: 0.5);
      cart.addItem('2', 'Full Price', 100.0);
      cart.addItem('3', 'Free', 100.0, discount: 1.0);

      expect(cart.subtotal, 300.0);
      expect(cart.totalDiscount, 150.0); // 50 + 0 + 100
      expect(cart.totalAmount, 150.0);
    });

    test('should handle precision with decimal calculations', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Item', 99.99, discount: 0.1);
      cart.updateQuantity('1', 3);

      // Subtotal: 299.97
      // Discount: 29.997
      // Total: 269.973
      expect(cart.subtotal, closeTo(299.97, 0.01));
      expect(cart.totalDiscount, closeTo(29.997, 0.01));
      expect(cart.totalAmount, closeTo(269.973, 0.01));
    });

    test('should maintain cart state after operations', () {
      final cart = ShoppingCartLogic();

      cart.addItem('1', 'Item1', 100.0);
      cart.addItem('2', 'Item2', 200.0);
      cart.addItem('3', 'Item3', 300.0);

      cart.updateQuantity('1', 5);
      cart.updateQuantity('2', 0); // Remove

      cart.addItem('4', 'Item4', 400.0, discount: 0.25);

      expect(cart.items.length, 3); // Item2 was removed
      expect(cart.totalItems, 7); // 5 + 1 + 1
      expect(cart.subtotal, 1200.0); // 500 + 300 + 400
      expect(cart.totalDiscount, 100.0); // 0 + 0 + 100
      expect(cart.totalAmount, 1100.0);
    });
  });

  group('ShoppingCart Widget - UI Integration', () {
    testWidgets('should display empty cart message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      expect(find.text('Cart is empty'), findsOneWidget);
    });

    testWidgets('should display correct total items count', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      expect(find.text('Total Items: 0'), findsOneWidget);
    });

    testWidgets('should add item when button is pressed', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      expect(find.text('Cart is empty'), findsNothing);
      expect(find.text('Total Items: 1'), findsOneWidget);
    });

    testWidgets(
      'should demonstrate duplicate handling with Add iPhone Again button',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: ShoppingCart())),
        );

        await tester.tap(find.text('Add iPhone'));
        await tester.pump();

        expect(find.text('Total Items: 1'), findsOneWidget);

        await tester.tap(find.text('Add iPhone Again'));
        await tester.pump();

        // Should update quantity, not create new entry
        expect(find.text('Total Items: 2'), findsOneWidget);
      },
    );

    testWidgets('should clear cart when clear button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      await tester.tap(find.text('Add iPhone'));
      await tester.tap(find.text('Add Galaxy'));
      await tester.pump();

      expect(find.text('Cart is empty'), findsNothing);

      await tester.tap(find.text('Clear Cart'));
      await tester.pump();

      expect(find.text('Cart is empty'), findsOneWidget);
      expect(find.text('Total Items: 0'), findsOneWidget);
    });
  });
}
