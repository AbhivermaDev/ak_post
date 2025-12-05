import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/shared_pref.dart';

void showLanguageDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Title
            const Text(
              "Change Language",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Choose your preferred language",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),

            /// English
            _languageTile(
              title: "English",
              subtitle: "Set app language to English",
              flag: "🇺🇸",
              selected: Get.locale?.languageCode == "en",
              onTap: () {
                Get.updateLocale(const Locale("en", "US"));
                SharedPref.setString(SharedPref.locale, "en");
                Get.back();
              },
            ),

            const SizedBox(height: 12),

            /// Hindi
            _languageTile(
              title: "हिन्दी",
              subtitle: "ऐप की भाषा हिन्दी करें",
              flag: "🇮🇳",
              selected: Get.locale?.languageCode == "hn",
              onTap: () {
                Get.updateLocale(const Locale("hn", "IN"));
                SharedPref.setString(SharedPref.locale, "hn");
                Get.back();
              },
            ),

            const SizedBox(height: 12),

            /// Marathi
            _languageTile(
              title: "मराठी",
              subtitle: "अॅपची भाषा मराठी करा",
              flag: "🇮🇳",
              selected: Get.locale?.languageCode == "mr",
              onTap: () {
                Get.updateLocale(const Locale("mr", "IN"));
                SharedPref.setString(SharedPref.locale, "mr");
                Get.back();
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}

/// ------------------------------
/// Reusable Language Tile Widget
/// ------------------------------
Widget _languageTile({
  required String title,
  required String subtitle,
  required String flag,
  required bool selected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? Colors.blue : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),

          /// Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.blue : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          /// Checkmark
          if (selected)
            const Icon(Icons.check_circle, color: Colors.blue, size: 24),
        ],
      ),
    ),
  );
}
