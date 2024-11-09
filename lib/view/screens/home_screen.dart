import 'package:barcode_mapping/global/common/colors/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrintPack Mobile App'),
      ),
      body: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildMenuCard(
              'Verified by GS1',
              'assets/images/gs1_icon.png',
              onTap: () {
                // Handle GS1 verification
              },
            ),
            _buildMenuCard(
              'Scann Barcode',
              'assets/images/scan_icon.png',
              onTap: () {
                // Handle barcode scanning
              },
            ),
            _buildMenuCard(
              'MAPPING BARCODE',
              'assets/images/mapping_barcode_icon.png',
              onTap: () {
                // Handle barcode mapping
              },
            ),
            _buildMenuCard(
              'MAPPING RFID',
              'assets/images/mapping_rfid_icon.png',
              onTap: () {
                // Handle RFID mapping
              },
            ),
            _buildMenuCard(
              'sample1',
              'assets/images/sample1.png',
              onTap: () {
                // Handle sample1
              },
            ),
            _buildMenuCard(
              'sample 2',
              'assets/images/sample2.png',
              onTap: () {
                // Handle sample2
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, String imagePath,
      {required VoidCallback onTap}) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 60,
                width: 60,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
