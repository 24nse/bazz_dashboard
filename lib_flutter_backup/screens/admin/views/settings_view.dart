import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: -2,
          )
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'General Settings',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF131B2E),
            ),
          ),
          const SizedBox(height: 24),
          const _SettingsTextField(label: 'Store Name', hintText: 'My Awesome Store'),
          const SizedBox(height: 20),
          const _SettingsTextField(label: 'Contact Email', hintText: 'admin@mystore.com'),
          const SizedBox(height: 20),
          const _SettingsDropdown(label: 'Currency', value: 'USD (\$)'),
          
          const SizedBox(height: 40),
          const Divider(color: Color(0xFFE2E8F0)),
          const SizedBox(height: 40),
          
          const Text(
            'Notifications',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF131B2E),
            ),
          ),
          const SizedBox(height: 24),
          _SettingsToggle(title: 'Order Confirmations', subtitle: 'Send email when an order is placed.', value: true, onChanged: (v) {}),
          const SizedBox(height: 16),
          _SettingsToggle(title: 'Shipping Updates', subtitle: 'Notify customers when their order ships.', value: true, onChanged: (v) {}),
          const SizedBox(height: 16),
          _SettingsToggle(title: 'Marketing Emails', subtitle: 'Send promotional materials and newsletters.', value: false, onChanged: (v) {}),
          
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF475569),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsTextField extends StatelessWidget {
  final String label;
  final String hintText;

  const _SettingsTextField({required this.label, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF94A3B8),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4F46E5)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Color(0xFF131B2E),
          ),
        ),
      ],
    );
  }
}

class _SettingsDropdown extends StatelessWidget {
  final String label;
  final String value;

  const _SettingsDropdown({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF131B2E),
                ),
              ),
              const Icon(Icons.expand_more, color: Color(0xFF94A3B8)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggle({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF131B2E),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: const Color(0xFF4F46E5),
        ),
      ],
    );
  }
}
