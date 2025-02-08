import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmTransferScreen extends StatelessWidget {
  final formatCurrency = NumberFormat("#,##0.00", "th_TH");

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final recipientPhone = args['recipientPhone'] as String;
    final recipientName = args['recipientName'] as String;
    final amount = args['amount'] as double;
    final message = args['message'] as String? ?? '';
    final walletBalance = args['walletBalance'] as double;
    final remainingBalance = walletBalance - amount;
    final fee = 0.00;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          'ยืนยันการโอน',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTransferAmount(amount),
                  SizedBox(height: 16),
                  _buildTransferDetails(
                    recipientName,
                    recipientPhone,
                    message,
                    amount,
                    fee,
                    remainingBalance,
                  ),
                ],
              ),
            ),
          ),
          _buildConfirmButton(context, args),
        ],
      ),
    );
  }

  Widget _buildTransferAmount(double amount) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'จำนวนเงินที่โอน',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '฿${formatCurrency.format(amount)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferDetails(
    String recipientName,
    String phone,
    String message,
    double amount,
    double fee,
    double remainingBalance,
  ) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildDetailItem(
            'ผู้รับเงิน',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipientName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  phone,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDivider(),
          if (message.isNotEmpty) ...[
            _buildDetailItem('ข้อความ', Text(message)),
            _buildDivider(),
          ],
          _buildDetailItem(
            'จำนวนเงินที่โอน',
            Text(
              '฿${formatCurrency.format(amount)}',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          _buildDivider(),
          _buildDetailItem(
            'ค่าธรรมเนียม',
            Text(
              '฿${formatCurrency.format(fee)}',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          _buildDivider(),
          _buildDetailItem(
            'ยอดเงินคงเหลือ',
            Text(
              '฿${formatCurrency.format(remainingBalance)}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, Widget content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey[200]);
  }

  Widget _buildConfirmButton(BuildContext context, Map<String, dynamic> args) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/otp',
                arguments: args,
              );
            },
            child: Text(
              'ยืนยันการโอน',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
