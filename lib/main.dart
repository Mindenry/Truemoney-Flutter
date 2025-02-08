import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'transfer_screen.dart';
import 'confirm_transfer_screen.dart';
import 'otp_verification_screen.dart';
import 'transfer_success_screen.dart';

void main() async {
  // Add these two lines
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('th_TH', null);

  runApp(TruemoneyWalletApp());
}

class TruemoneyWalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Sarabun'),
      home: HomeScreen(),
      routes: {
        '/transfer': (context) => TransferScreen(),
        '/confirm': (context) => ConfirmTransferScreen(),
        '/otp': (context) => OTPVerificationScreen(),
        '/success': (context) => TransferSuccessScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Image.asset(
          'assets/logo_true_money.png',
          height: 24,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildQuickActions(context), // ส่ง context ไปยัง _buildQuickActions
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  _buildSectionTitle('บริการยอดนิยม'),
                  _buildPopularServices(),
                  SizedBox(height: 24),
                  _buildSectionTitle('เติมเงินและชำระบิล'),
                  _buildPaymentServices(),
                  SizedBox(height: 24),
                  _buildPromotions(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    // เพิ่ม context เข้ามา
    return Container(
      color: Colors.orange,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickAction(Icons.account_balance_wallet, 'เติมเงินเข้าบัญชี',
              onPressed: () {}),
          _buildQuickAction(Icons.send, 'โอนเงิน', onPressed: () {
            Navigator.pushNamed(
                context, '/transfer'); // ใช้ context ที่ส่งเข้ามา
          }),
          _buildQuickAction(Icons.qr_code_scanner, 'สแกน', onPressed: () {}),
          _buildQuickAction(Icons.payment, 'จ่ายเงิน', onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label,
      {VoidCallback? onPressed}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(icon, color: Colors.orange, size: 30),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildPopularServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildServiceButton(Icons.payment, 'PromptPay'),
          _buildServiceButton(Icons.credit_card, 'บัตร WeCard'),
          _buildServiceButton(Icons.shopping_cart, 'ซื้อตั๋วเติมเงิน'),
          _buildServiceButton(Icons.store, 'จ่ายเงินที่ 7-Eleven'),
        ],
      ),
    );
  }

  Widget _buildPaymentServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildServiceButton(Icons.phone_android, 'เติมเงินมือถือ'),
          _buildServiceButton(Icons.electric_bolt, 'จ่ายบิลค่าน้ำ-ไฟ'),
          _buildServiceButton(Icons.tv, 'ดูรายการบิลที่จ่าย'),
          _buildServiceButton(Icons.more_horiz, 'ทรูออนไลน์'),
        ],
      ),
    );
  }

  Widget _buildPromotions() {
    return Container(
      height: 140,
      color: Colors.grey[200],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 220,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text('Promotion ${index + 1}',
                  style: TextStyle(color: Colors.black)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.orange[100],
          child: Icon(icon, color: Colors.orange, size: 30),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_offer), label: 'โปรโมชั่น'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'บัญชี'),
      ],
    );
  }
}
