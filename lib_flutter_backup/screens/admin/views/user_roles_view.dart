import 'package:flutter/material.dart';

class UserRolesView extends StatelessWidget {
  const UserRolesView({super.key});

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
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Admin Users',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131B2E),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_outlined, size: 20),
                  label: const Text('Invite User'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          // Users Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  headingTextStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                  dataTextStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFF131B2E),
                  ),
                  columns: const [
                    DataColumn(label: Text('User')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _dummyAdminUsers.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                                child: Text(
                                  user['name']![0],
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4F46E5),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        DataCell(Text(user['email']!)),
                        DataCell(_RoleBadge(role: user['role']!)),
                        DataCell(_StatusDot(isActive: user['active'] == 'true')),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> _dummyAdminUsers = [
  {'name': 'Admin Owner', 'email': 'owner@bazz.store', 'role': 'Super Admin', 'active': 'true'},
  {'name': 'Sarah Manager', 'email': 'sarah@bazz.store', 'role': 'Manager', 'active': 'true'},
  {'name': 'Ahmed Support', 'email': 'ahmed@bazz.store', 'role': 'Support', 'active': 'true'},
  {'name': 'Lina Editor', 'email': 'lina@bazz.store', 'role': 'Editor', 'active': 'false'},
];

class _RoleBadge extends StatelessWidget {
  final String role;

  const _RoleBadge({required this.role});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (role) {
      case 'Super Admin':
        color = const Color(0xFF4F46E5);
        break;
      case 'Manager':
        color = const Color(0xFF3B82F6);
        break;
      case 'Editor':
        color = const Color(0xFFF59E0B);
        break;
      default:
        color = const Color(0xFF10B981);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        role,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;

  const _StatusDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          isActive ? 'Active' : 'Inactive',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            color: isActive ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }
}
