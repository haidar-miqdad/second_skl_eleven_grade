import 'package:flutter/material.dart';
import 'package:flutter_second_skl_eleven_grade/presentation/home/models/order_item.dart';
import '../../../../../../core/assets/assets.gen.dart';
import '../../../../../../core/components/menu_button.dart';
import '../../../../../../core/components/spaces.dart';
import '../widgets/order_card.dart';
import '../widgets/payment_cash_dialog.dart';
import '../widgets/payment_qris_dialog.dart';
import '../widgets/process_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final indexValue = ValueNotifier(0);

  // Static data for demonstration
  List<OrderItem> orders = [
    OrderItem(product: Product(name: "Product 1", price: 10000), quantity: 2),
    OrderItem(product: Product(name: "Product 2", price: 15000), quantity: 1),
  ];

  int totalPrice = 0;

  int calculateTotalPrice(List<OrderItem> orders) {
    return orders.fold(
      0,
      (previousValue, element) =>
          previousValue + element.product.price * element.quantity,
    );
  }

  @override
  void initState() {
    super.initState();
    totalPrice = calculateTotalPrice(
        orders); // Calculate the total price on initialization
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Show dialog to save order
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Open Bill'),
                    content: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Order Name',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Open bill success snack bar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Open Bill Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.save_as_outlined),
          ),
          const SpaceWidth(8),
        ],
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text('No Data'),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemCount: orders.length,
              separatorBuilder: (context, index) => const SpaceHeight(20.0),
              itemBuilder: (context, index) => OrderCard(
                padding: paddingHorizontal,
                data: orders[index],
                onDeleteTap: () {},
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: indexValue,
              builder: (context, value, _) => Row(
                children: [
                  MenuButton(
                    iconPath: Assets.icons.cash.path,
                    label: 'CASH',
                    isActive: value == 1,
                    onPressed: () {
                      indexValue.value = 1;
                    },
                  ),
                  const SpaceWidth(16.0),
                  MenuButton(
                    iconPath: Assets.icons.qrCode.path,
                    label: 'QR',
                    isActive: value == 2,
                    onPressed: () {
                      indexValue.value = 2;
                    },
                  ),
                  const SpaceWidth(16.0),
                  MenuButton(
                    iconPath: Assets.icons.debit.path,
                    label: 'TRANSFER',
                    isActive: value == 3,
                    onPressed: () {
                      indexValue.value = 3;
                    },
                  ),
                ],
              ),
            ),
            const SpaceHeight(20.0),
            ProcessButton(
              price: totalPrice,
              onPressed: () {
                if (indexValue.value == 0) {
                  // Show message to select a payment method
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a payment method.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (indexValue.value == 1) {
                  showDialog(
                    context: context,
                    builder: (context) => PaymentCashDialog(
                      price: totalPrice,
                    ),
                  );
                } else if (indexValue.value == 2) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => PaymentQrisDialog(
                      price: totalPrice,
                    ),
                  );
                }
              },
              total: 'Rp.25.000',
            ),
          ],
        ),
      ),
    );
  }
}
