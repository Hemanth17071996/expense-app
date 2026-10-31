import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/user_model.dart';
import '../services/app_data_service.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final AppDataService _dataService = AppDataService();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _dataService.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _dataService.removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) setState(() {});
  }

  void _openAddUserModal() {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    String selectedRole = 'Engineering Member';
    Color selectedColor = const Color(0xFF6366F1);

    final List<String> roles = [
      'Engineering Member',
      'Finance Manager',
      'Operations Lead',
      'Product Designer',
      'QA Lead',
      'Admin / Lead',
    ];

    final List<Color> colorOptions = [
      const Color(0xFF6366F1), // Indigo
      const Color(0xFF06B6D4), // Cyan
      const Color(0xFF10B981), // Emerald
      const Color(0xFFF59E0B), // Amber
      const Color(0xFFEC4899), // Pink
      const Color(0xFF8B5CF6), // Purple
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add New User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textMuted),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.cardGlassBorder),
                    const SizedBox(height: 12),

                    // Full Name
                    const Text('Full Display Name',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. Karthik Raja',
                        hintStyle: const TextStyle(color: AppColors.textMuted),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Username & Role Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Username',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              TextField(
                                controller: usernameController,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'e.g. karthik',
                                  hintStyle: const TextStyle(
                                      color: AppColors.textMuted),
                                  filled: true,
                                  fillColor: const Color(0xFF1E293B),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Assigned Role',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E293B),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedRole,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: const Color(0xFF1E293B),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12.5),
                                  items: roles
                                      .map((r) => DropdownMenuItem(
                                          value: r, child: Text(r)))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setModalState(() => selectedRole = val);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Email Address
                    const Text('Email Address',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'karthik@example.com',
                        hintStyle: const TextStyle(color: AppColors.textMuted),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Phone Number
                    const Text('Mobile Number',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: '+91 9876543210',
                        hintStyle: const TextStyle(color: AppColors.textMuted),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Avatar Color Picker
                    const Text('Profile Theme Color',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 8),
                    Row(
                      children: colorOptions.map((c) {
                        final isChosen = selectedColor == c;
                        return GestureDetector(
                          onTap: () => setModalState(() => selectedColor = c),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isChosen ? Colors.white : Colors.transparent,
                                width: 2.5,
                              ),
                              boxShadow: isChosen
                                  ? [
                                      BoxShadow(
                                          color: c.withOpacity(0.5),
                                          blurRadius: 8)
                                    ]
                                  : null,
                            ),
                            child: isChosen
                                ? const Icon(Icons.check,
                                    size: 16, color: Colors.white)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          final name = nameController.text.trim();
                          final username = usernameController.text.trim();
                          final email = emailController.text.trim();
                          final phone = phoneController.text.trim();

                          if (name.isEmpty || username.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill out Name and Username!'),
                                backgroundColor: AppColors.rose,
                              ),
                            );
                            return;
                          }

                          // Calculate initials
                          final parts = name.split(' ');
                          String initials = '';
                          if (parts.length >= 2) {
                            initials =
                                '${parts[0][0]}${parts[1][0]}'.toUpperCase();
                          } else if (name.isNotEmpty) {
                            initials = name.substring(0, 1).toUpperCase();
                          }

                          final newUser = UserModel(
                            id: 'usr-${DateTime.now().millisecondsSinceEpoch}',
                            username: username,
                            displayName: name,
                            role: selectedRole,
                            email: email.isNotEmpty ? email : '$username@example.com',
                            phone: phone.isNotEmpty ? phone : '+91 9655774087',
                            initials: initials.isNotEmpty ? initials : 'U',
                            avatarColor: selectedColor,
                          );

                          _dataService.addUser(newUser);
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('User $name successfully registered!'),
                              backgroundColor: AppColors.emerald,
                            ),
                          );
                        },
                        child: const Text(
                          'Register User',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _dataService.users.where((u) {
      final q = _searchQuery.toLowerCase();
      return _searchQuery.isEmpty ||
          u.displayName.toLowerCase().contains(q) ||
          u.role.toLowerCase().contains(q) ||
          u.username.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1019),
        elevation: 0,
        title: const Text(
          'Multi-User Management',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_rounded,
                color: AppColors.cyan),
            tooltip: 'Add User',
            onPressed: _openAddUserModal,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('Add User',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: _openAddUserModal,
      ),
      body: Column(
        children: [
          // Header Stats Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: const Color(0xFF0E1424),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Registered Users',
                        style: TextStyle(
                            color: AppColors.textMuted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text(
                      '${_dataService.users.length} Active Members',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.shield_outlined,
                          size: 13, color: AppColors.primaryLight),
                      SizedBox(width: 4),
                      Text(
                        'RBAC Active',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              style: const TextStyle(color: Colors.white, fontSize: 13.5),
              decoration: InputDecoration(
                hintText: 'Search user by name, role, or username...',
                hintStyle:
                    const TextStyle(color: AppColors.textMuted, fontSize: 13),
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: const Color(0xFF131B2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.cardGlassBorder),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          // User List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
              itemCount: filteredUsers.length,
              itemBuilder: (context, idx) {
                final user = filteredUsers[idx];
                final isLead = user.username.toLowerCase() == 'hemanth';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isLead
                          ? AppColors.primary.withOpacity(0.4)
                          : AppColors.cardGlassBorder,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: user.avatarColor,
                      child: Text(
                        user.initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          user.displayName,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (isLead) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: AppColors.primary.withOpacity(0.4)),
                            ),
                            child: const Text(
                              'LEAD',
                              style: TextStyle(
                                  fontSize: 9.5,
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 3),
                        Text(
                          user.role,
                          style: const TextStyle(
                            color: AppColors.cyan,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(Icons.email_outlined,
                                size: 12, color: AppColors.textMuted),
                            const SizedBox(width: 4),
                            Text(
                              user.email,
                              style: const TextStyle(
                                  color: AppColors.textMuted, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: isLead
                        ? const Icon(Icons.verified,
                            color: AppColors.cyan, size: 20)
                        : IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: AppColors.rose, size: 20),
                            onPressed: () {
                              _dataService.deleteUser(user.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'User ${user.displayName} removed'),
                                  backgroundColor: AppColors.rose,
                                ),
                              );
                            },
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
