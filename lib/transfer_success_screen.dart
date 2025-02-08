import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class TransferSuccessScreen extends StatelessWidget {
  final formatCurrency = intl.NumberFormat("#,##0.00", "th_TH");
  final formatDateTime = intl.DateFormat("dd/MM/yyyy HH:mm", "th_TH");

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
    final transferId = DateTime.now().millisecondsSinceEpoch.toString();
    final transferTime = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          'โอนเงินสำเร็จ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSuccessHeader(amount),
                  SizedBox(height: 24),
                  _buildTransferDetails(
                    recipientName: recipientName,
                    recipientPhone: recipientPhone,
                    message: message,
                    amount: amount,
                    fee: fee,
                    remainingBalance: remainingBalance,
                    transferId: transferId,
                    transferTime: transferTime,
                  ),
                ],
              ),
            ),
          ),
          _buildHomeButton(context),
        ],
      ),
    );
  }

  Widget _buildSuccessHeader(double amount) {
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
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'โอนเงินสำเร็จ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
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

  Widget _buildTransferDetails({
    required String recipientName,
    required String recipientPhone,
    required String message,
    required double amount,
    required double fee,
    required double remainingBalance,
    required String transferId,
    required DateTime transferTime,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDetailItem('ผู้รับเงิน', recipientName),
            _buildDetailItem('เบอร์โทรศัพท์', recipientPhone),
            if (message.isNotEmpty) _buildDetailItem('ข้อความ', message),
            _buildDetailItem(
                'วันที่-เวลา', formatDateTime.format(transferTime)),
            _buildDetailItem('เลขที่อ้างอิง', transferId),
            _buildDetailItem('จำนวนเงิน', '฿${formatCurrency.format(amount)}'),
            _buildDetailItem('ค่าธรรมเนียม', '฿${formatCurrency.format(fee)}'),
            _buildDetailItem(
                'ยอดเงินรวม', '฿${formatCurrency.format(amount + fee)}'),
            _buildDetailItem(
                'เงินคงเหลือ', '฿${formatCurrency.format(remainingBalance)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
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
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
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
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text(
              'กลับสู่หน้าหลัก',
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
