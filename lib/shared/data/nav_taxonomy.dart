import 'package:flutter/material.dart';

// Single source of truth for the five-pillar navigation taxonomy.
// Used by CategoryDrawer and the home screen category grid.

enum NavColorRole { primary, secondary, tertiary }

extension NavColorRoleX on NavColorRole {
  Color containerColor(ColorScheme cs) => switch (this) {
        NavColorRole.primary => cs.primaryContainer,
        NavColorRole.secondary => cs.secondaryContainer,
        NavColorRole.tertiary => cs.tertiaryContainer,
      };

  Color onContainerColor(ColorScheme cs) => switch (this) {
        NavColorRole.primary => cs.onPrimaryContainer,
        NavColorRole.secondary => cs.onSecondaryContainer,
        NavColorRole.tertiary => cs.onTertiaryContainer,
      };
}

class NavItem {
  final String label;
  const NavItem(this.label);
}

class NavGroup {
  final String name;
  final List<NavItem> items;
  const NavGroup(this.name, this.items);
}

class NavCategory {
  final String name;
  final IconData icon;
  final NavColorRole colorRole;
  final List<NavGroup> groups;

  const NavCategory({
    required this.name,
    required this.icon,
    required this.colorRole,
    required this.groups,
  });

  int get totalItems => groups.fold(0, (sum, g) => sum + g.items.length);
}

const kNavTaxonomy = <NavCategory>[
  NavCategory(
    name: 'Massage',
    icon: Icons.self_improvement_outlined,
    colorRole: NavColorRole.primary,
    groups: [
      NavGroup('Techniques', [
        NavItem('Swedish Massage'),
        NavItem('Deep Tissue Massage'),
        NavItem('Shiatsu Massage'),
        NavItem('Hot Stone Massage'),
        NavItem('Reflexology'),
        NavItem('Tui Na'),
      ]),
      NavGroup('Specialty & Targeted', [
        NavItem('Couples Massage'),
        NavItem('Prenatal Massage'),
        NavItem('Full Body Massage'),
        NavItem('Foot Massage'),
      ]),
      NavGroup('Professional', [
        NavItem('Massage Therapy'),
        NavItem('Massage Schools'),
      ]),
    ],
  ),
  NavCategory(
    name: 'Spas & Retreats',
    icon: Icons.hot_tub,
    colorRole: NavColorRole.secondary,
    groups: [
      NavGroup('Locations & Getaways', [
        NavItem('Day Spas'),
        NavItem('Medical Spas'),
        NavItem('Health Retreats'),
        NavItem('Hotels & Travel'),
      ]),
      NavGroup('Thermal & Water Therapies', [
        NavItem('Saunas'),
        NavItem('Hydrotherapy'),
        NavItem('Halotherapy'),
        NavItem('Float Spa'),
      ]),
      NavGroup('Specialty Treatments', [
        NavItem('Cryotherapy'),
        NavItem('IV Hydration'),
        NavItem('Colonics'),
      ]),
    ],
  ),
  NavCategory(
    name: 'Skin & Beauty',
    icon: Icons.face_retouching_natural,
    colorRole: NavColorRole.tertiary,
    groups: [
      NavGroup('Face & Skin Care', [
        NavItem('Skin Care'),
        NavItem('Estheticians'),
        NavItem('Acne Treatment'),
        NavItem('Dermatologists'),
        NavItem('Cosmetics & Beauty Supply'),
      ]),
      NavGroup('Cosmetics & Features', [
        NavItem('Makeup Artists'),
        NavItem('Permanent Makeup'),
        NavItem('Eyelash Service'),
        NavItem('Eyebrow Services'),
      ]),
      NavGroup('Enhancements', [
        NavItem('Body Contouring'),
        NavItem('Teeth Whitening'),
        NavItem('Tanning'),
        NavItem('Spray Tanning'),
        NavItem('Tattoo Removal'),
      ]),
    ],
  ),
  NavCategory(
    name: 'Hair & Nails',
    icon: Icons.content_cut,
    colorRole: NavColorRole.primary,
    groups: [
      NavGroup('Hair & Styling', [
        NavItem('Hair Salons'),
        NavItem('Hair Stylists'),
        NavItem('Hair Loss Centers'),
      ]),
      NavGroup('Hair Removal', [
        NavItem('Laser Hair Removal'),
        NavItem('Waxing'),
      ]),
      NavGroup('Nail Salons', [
        NavItem('Nail Salons'),
        NavItem('Nail Technicians'),
      ]),
    ],
  ),
  NavCategory(
    name: 'Health & Wellness',
    icon: Icons.favorite_border,
    colorRole: NavColorRole.secondary,
    groups: [
      NavGroup('Holistic & Alternative', [
        NavItem('Alternative Medicine'),
        NavItem('Acupuncture'),
        NavItem('Ayurveda'),
        NavItem('Traditional Chinese Medicine'),
        NavItem('Naturopathic / Holistic'),
        NavItem('Reiki'),
      ]),
      NavGroup('Clinical & Physical', [
        NavItem('Chiropractors'),
        NavItem('Physical Therapy'),
        NavItem('Weight Loss Centers'),
        NavItem('Nutritionists'),
        NavItem('Health Coach'),
        NavItem('Prenatal / Perinatal Care'),
      ]),
      NavGroup('Movement & Mindfulness', [
        NavItem('Yoga'),
      ]),
    ],
  ),
];
