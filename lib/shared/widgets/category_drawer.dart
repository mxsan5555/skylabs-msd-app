import 'package:flutter/material.dart';
import '../data/nav_taxonomy.dart';

// Accordion-style NavigationDrawer mapping the five-pillar taxonomy.
// Each top-level category expands to reveal its groups and items.

class CategoryDrawer extends StatelessWidget {
  const CategoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return NavigationDrawer(
      children: [
        // --- Header ---
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.spa_rounded,
                  size: 24,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MSD',
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'MySpaDeal',
                    style: textTheme.bodySmall
                        ?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ),

        Divider(height: 1, color: colorScheme.outlineVariant),
        const SizedBox(height: 4),

        // --- Five-pillar category accordion ---
        for (final category in kNavTaxonomy)
          _CategoryTile(category: category),

        const SizedBox(height: 4),
        Divider(height: 1, color: colorScheme.outlineVariant),
        const SizedBox(height: 8),

        // --- Utility links ---
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: Text(
            'More',
            style: textTheme.labelLarge
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ),
        _UtilityTile(icon: Icons.info_outline_rounded, label: 'About Us'),
        _UtilityTile(icon: Icons.mail_outline_rounded, label: 'Contact'),
        _UtilityTile(icon: Icons.work_outline_rounded, label: 'Careers'),
        _UtilityTile(
            icon: Icons.privacy_tip_outlined, label: 'Privacy Policy'),
        _UtilityTile(
            icon: Icons.gavel_rounded, label: 'Terms of Service'),
        _UtilityTile(
            icon: Icons.accessibility_new_rounded,
            label: 'Accessibility Statement'),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ---------------------------------------------------------------------------

class _CategoryTile extends StatelessWidget {
  final NavCategory category;
  const _CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accentColor = category.colorRole.containerColor(colorScheme);

    return ExpansionTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          category.icon,
          size: 20,
          color: category.colorRole.onContainerColor(colorScheme),
        ),
      ),
      title: Text(category.name, style: textTheme.titleSmall),
      subtitle: Text(
        '${category.totalItems} services',
        style:
            textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
      ),
      tilePadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      childrenPadding: EdgeInsets.zero,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      // Remove default border lines from ExpansionTile
      shape: const RoundedRectangleBorder(),
      collapsedShape: const RoundedRectangleBorder(),
      children: [
        for (final group in category.groups) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Text(
              group.name,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          for (final item in group.items)
            ListTile(
              title: Text(item.label, style: textTheme.bodyMedium),
              onTap: () => Navigator.pop(context),
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
              dense: true,
              visualDensity: VisualDensity.compact,
              minLeadingWidth: 0,
            ),
          const SizedBox(height: 4),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------

class _UtilityTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _UtilityTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
