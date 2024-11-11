import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_mapping/core/constants/app_icons.dart';
import 'package:barcode_mapping/global/common/colors/app_colors.dart';
import 'package:barcode_mapping/global/common/utils/app_navigator.dart';
import 'package:barcode_mapping/view/screens/capture/Mapping_Barcode/BarcodeMappingScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          crossAxisSpacing: 8,
          childAspectRatio: 1.2,
          children: [
            _buildMenuCard(
              'Verified by GS1',
              AppIcons.icVerifiedByGs1,
              onTap: () {
                // Handle GS1 verification
              },
            ),
            _buildMenuCard(
              'Scan Barcode',
              AppIcons.icScanBarcode,
              onTap: () {
                // Handle barcode scanning
              },
            ),
            _buildMenuCard(
              'MAPPING BARCODE',
              AppIcons.icMappingBarcode,
              onTap: () {
                // Handle barcode mapping
                AppNavigator.goToPage(
                  context: context,
                  screen: BarcodeMappingScreen(),
                );
              },
            ),
            _buildMenuCard(
              'MAPPING RFID',
              AppIcons.icMappingRfid,
              onTap: () {
                // Handle RFID mapping
              },
            ),
            // _buildMenuCard(
            //   'sample1',
            //   'assets/images/sample1.png',
            //   onTap: () {
            //     // Handle sample1
            //   },
            // ),
            // _buildMenuCard(
            //   'sample 2',
            //   'assets/images/sample2.png',
            //   onTap: () {
            //     // Handle sample2
            //   },
            // ),
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
                height: 80,
                width: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              AutoSizeText(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
