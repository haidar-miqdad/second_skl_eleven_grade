import 'package:flutter/material.dart';
import 'package:flutter_second_skl_eleven_grade/core/extensions/int_ext.dart';
import 'package:flutter_second_skl_eleven_grade/core/extensions/string_ext.dart';
import 'package:flutter_second_skl_eleven_grade/presentation/order/widgets/payment_success_dialog.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/components/buttons.dart';
import '../../../../../../core/components/custom_text_field.dart';
import '../../../../../../core/components/spaces.dart';
import '../../../../../../core/constants/colors.dart';

// Define the OrderModel class here or import it if it's defined elsewhere
class OrderModel {
  final String paymentMethod;
  final int nominalBayar;
  final List<String> orders;
  final int totalQuantity;
  final int totalPrice;
  final String idKasir;
  final String namaKasir;
  final String transactionTime;
  final bool isSync;

  OrderModel({
    required this.paymentMethod,
    required this.nominalBayar,
    required this.orders,
    required this.totalQuantity,
    required this.totalPrice,
    required this.idKasir,
    required this.namaKasir,
    required this.transactionTime,
    required this.isSync,
  });
}

// Assuming ProductLocalDatasource is defined elsewhere
class ProductLocalDatasource {
  static final instance = ProductLocalDatasource();

  void saveOrder(OrderModel orderModel) {
    // Save logic here (e.g., save to a database)
    print("Order saved: ${orderModel.orders}");
  }
}

class PaymentCashDialog extends StatefulWidget {
  final int price;

  const PaymentCashDialog({super.key, required this.price});

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  TextEditingController? priceController;

  @override
  void initState() {
    priceController =
        TextEditingController(text: widget.price.currencyFormatRp);
    super.initState();
  }

  void _handlePayment() {
    final int nominal = priceController!.text.toIntegerFromText;

    // Static data for the order
    final orderModel = OrderModel(
      paymentMethod: 'Cash',
      nominalBayar: nominal,
      orders: [
        'Coffee (x2)',
        'Tea (x1)',
        'Sandwich (x1)',
        'Cake (x3)',
      ],
      totalQuantity: 7, // Total quantity from static data
      totalPrice: widget.price, // Total price passed to the dialog
      idKasir: 'dummy_id', // Example cashier ID
      namaKasir: 'dummy_name', // Example cashier name
      transactionTime: DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()),
      isSync: false,
    );

    ProductLocalDatasource.instance.saveOrder(orderModel);
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) =>  PaymentSuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Stack(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.highlight_off),
            color: AppColors.primary,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Payment - Cash',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceHeight(16.0),
          CustomTextField(
            controller: priceController!,
            label: '',
            showLabel: false,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final int priceValue = value.toIntegerFromText;
              priceController!.text = priceValue.currencyFormatRp;
              priceController!.selection = TextSelection.fromPosition(
                TextPosition(offset: priceController!.text.length),
              );
            },
          ),
          const SpaceHeight(30.0),
          Button.filled(
            onPressed: _handlePayment,
            label: 'Pay',
          ),
        ],
      ),
    );
  }
}
