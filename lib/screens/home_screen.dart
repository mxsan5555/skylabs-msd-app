import 'package:flutter/material.dart';
import 'search_results_screen.dart';
import '../shared/data/nav_taxonomy.dart';
import '../shared/utils/deal_images.dart';
import '../shared/widgets/category_drawer.dart';

// ---------------------------------------------------------------------------
// Hero carousel card — used by the Featured Deals CarouselView.weighted
// ---------------------------------------------------------------------------

class _FeaturedHeroCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String tag;

  const _FeaturedHeroCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        // Full-bleed image — OverflowBox keeps it at hero width during transitions
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 7 / 8,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        // Gradient scrim for text legibility
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.35, 1.0],
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.70),
                ],
              ),
            ),
          ),
        ),
        // Tag chip — top right
        Positioned(
          top: 12,
          right: 12,
          child: Chip(
            label: Text(tag),
            labelStyle: textTheme.labelSmall
                ?.copyWith(color: colorScheme.onSecondaryContainer),
            backgroundColor: colorScheme.secondaryContainer,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide.none,
          ),
        ),
        // Title + subtitle overlaid at bottom left
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Category card — home screen 2-2-1 grid tile
// ---------------------------------------------------------------------------

class _CategoryCard extends StatelessWidget {
  final NavCategory category;
  final VoidCallback onTap;
  final bool fullWidth;

  const _CategoryCard({
    required this.category,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bg = category.colorRole.containerColor(colorScheme);
    final fg = category.colorRole.onContainerColor(colorScheme);

    return Card(
      color: bg,
      elevation: 0,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: fullWidth
              ? Row(
                  children: [
                    Icon(category.icon, size: 32, color: fg),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category.name,
                              style: textTheme.titleMedium
                                  ?.copyWith(color: fg)),
                          const SizedBox(height: 2),
                          Text(
                            '${category.totalItems} services',
                            style: textTheme.bodySmall?.copyWith(
                                color: fg.withValues(alpha: 0.7)),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: fg.withValues(alpha: 0.6)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(category.icon, size: 28, color: fg),
                    const SizedBox(height: 12),
                    Text(
                      category.name,
                      style: textTheme.titleSmall?.copyWith(
                          color: fg, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${category.totalItems} services',
                      style: textTheme.bodySmall
                          ?.copyWith(color: fg.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private data models (file-scoped)
// ---------------------------------------------------------------------------

class _SpaDeal {
  final String title;
  final String subtitle;
  final String image;
  final String price;
  const _SpaDeal(this.title, this.subtitle, this.image, this.price);
}

class _SpaDealCategory {
  final String name;
  final IconData icon;
  final List<_SpaDeal> deals;
  const _SpaDealCategory(this.name, this.icon, this.deals);
}

// ---------------------------------------------------------------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final CarouselController _featuredController =
      CarouselController(initialItem: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _featuredController.dispose();
    super.dispose();
  }

  // Featured deals — top carousel (d-1 to d-5)
  static final _featuredDeals = [
    (
      title: 'Summer Glow Package',
      subtitle: 'Full body treatment • 90 min',
      image: kDealImages[0],
      tag: '30% OFF'
    ),
    (
      title: 'Deep Tissue Massage',
      subtitle: 'Stress relief therapy • 60 min',
      image: kDealImages[1],
      tag: 'Popular'
    ),
    (
      title: 'Facial Rejuvenation',
      subtitle: 'Anti-aging skincare • 45 min',
      image: kDealImages[2],
      tag: 'New'
    ),
    (
      title: 'Aromatherapy Bliss',
      subtitle: 'Essential oils therapy • 75 min',
      image: kDealImages[3],
      tag: 'Best Seller'
    ),
    (
      title: 'Hot Stone Therapy',
      subtitle: 'Deep relaxation • 90 min',
      image: kDealImages[4],
      tag: '20% OFF'
    ),
  ];


  // Hot right now — compact carousel (d-6 to d-10)
  static final _hotDeals = [
    (
      title: 'Couples Retreat',
      subtitle: 'For two • 90 min',
      image: kDealImages[5],
      tag: 'Hot'
    ),
    (
      title: 'Detox Body Wrap',
      subtitle: 'Full cleanse • 60 min',
      image: kDealImages[6],
      tag: '25% OFF'
    ),
    (
      title: 'Luxury Gold Facial',
      subtitle: 'Anti-aging • 75 min',
      image: kDealImages[7],
      tag: 'Limited'
    ),
    (
      title: 'Scalp & Hair Spa',
      subtitle: 'Deep care • 45 min',
      image: kDealImages[8],
      tag: 'New'
    ),
    (
      title: 'Ayurvedic Retreat',
      subtitle: 'Traditional • 2 hr',
      image: kDealImages[9],
      tag: '15% OFF'
    ),
  ];

  // Deals grouped by category — horizontal scrollable rows
  // Category 0: global 0–3  → image indices 10–13 (d-11 to d-14)
  // Category 1: global 4–7  → image indices 14, 0, 1, 2 (d-15, d-1, d-2, d-3)
  // Category 2: global 8–11 → image indices 3–6 (d-4 to d-7)
  static final _dealCategories = [
    _SpaDealCategory('Massage Therapy', Icons.self_improvement_outlined, [
      _SpaDeal('Swedish Bliss', '60 min • Studio', kDealImages[10], r'$$'),
      _SpaDeal('Thai Full Body', '90 min • Clinic', kDealImages[11], r'$'),
      _SpaDeal('Hot Stone Therapy', '75 min • Spa', kDealImages[12], r'$$$'),
      _SpaDeal('Shiatsu Pressure', '60 min • Studio', kDealImages[13], r'$$'),
    ]),
    _SpaDealCategory('Facial & Skin', Icons.face_retouching_natural, [
      _SpaDeal('Hydra Glow Facial', '45 min • Salon', kDealImages[14], r'$$'),
      _SpaDeal('Anti-Aging Peel', '60 min • Clinic', kDealImages[0], r'$$$'),
      _SpaDeal('Brightening Mask', '30 min • Studio', kDealImages[1], r'$'),
      _SpaDeal('Gold Collagen', '75 min • Spa', kDealImages[2], r'$$$$'),
    ]),
    _SpaDealCategory('Nail Care', Icons.back_hand_outlined, [
      _SpaDeal('Gel Manicure', '45 min • Salon', kDealImages[3], r'$'),
      _SpaDeal('Spa Pedicure', '60 min • Studio', kDealImages[4], r'$$'),
      _SpaDeal('Nail Art Design', '30 min • Salon', kDealImages[5], r'$'),
      _SpaDeal('Paraffin Wax', '45 min • Spa', kDealImages[6], r'$$'),
    ]),
  ];

  // -------------------------------------------------------------------------
  // Helper builders
  // -------------------------------------------------------------------------

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning,';
    if (h < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  Widget _buildCtaBanner({
    required IconData icon,
    required String tag,
    required String headline,
    required String body,
    required String actionLabel,
    required Color containerColor,
    required Color onContainerColor,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: containerColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: onContainerColor, size: 20),
                const SizedBox(width: 8),
                Chip(
                  label: Text(tag),
                  labelStyle: textTheme.labelSmall
                      ?.copyWith(color: onContainerColor),
                  side: BorderSide(color: onContainerColor.withValues(alpha: 0.4)),
                  backgroundColor: containerColor,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              headline,
              style: textTheme.titleLarge
                  ?.copyWith(color: onContainerColor),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: textTheme.bodyMedium
                  ?.copyWith(color: onContainerColor.withValues(alpha: 0.85)),
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: onContainerColor,
                foregroundColor: containerColor,
              ),
              onPressed: () {},
              child: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Home body
  // -------------------------------------------------------------------------

  Widget _buildHomeBody(ColorScheme colorScheme, ThemeData theme) {
    final textTheme = theme.textTheme;

    return CustomScrollView(
      slivers: [
        // App bar
        SliverAppBar(
          floating: true,
          snap: true,
          centerTitle: false,
          backgroundColor: colorScheme.surfaceContainerLowest,
          scrolledUnderElevation: 1,
          surfaceTintColor: colorScheme.primary,
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            tooltip: 'Browse categories',
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_greeting,
                  style: textTheme.labelMedium
                      ?.copyWith(color: colorScheme.onSurfaceVariant)),
              Text('Welcome back', style: textTheme.titleMedium),
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {}),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    'S',
                    style: textTheme.labelLarge
                        ?.copyWith(color: colorScheme.onPrimaryContainer),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Search bar — tapping navigates to search results
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          sliver: SliverToBoxAdapter(
            child: SearchBar(
              hintText: 'Search spas, treatments...',
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16)),
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                  icon: const Icon(Icons.tune_outlined),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchResultsScreen()),
                  ),
                )
              ],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SearchResultsScreen()),
              ),
            ),
          ),
        ),

        // Featured Deals header
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                    child: Text('Featured Deals',
                        style: textTheme.titleLarge)),
                TextButton(onPressed: () {}, child: const Text('See all')),
              ],
            ),
          ),
        ),

        // Featured Deals carousel — M3 Hero layout
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.38,
            ),
            child: CarouselView.weighted(
              controller: _featuredController,
              itemSnapping: true,
              flexWeights: const [1, 7, 1],
              onTap: (_) {},
              children: _featuredDeals
                  .map((deal) => _FeaturedHeroCard(
                        title: deal.title,
                        subtitle: deal.subtitle,
                        image: deal.image,
                        tag: deal.tag,
                      ))
                  .toList(),
            ),
          ),
        ),

        // Browse by Category header
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                    child: Text('Browse by Category',
                        style: textTheme.titleLarge)),
                TextButton(
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  child: const Text('See all'),
                ),
              ],
            ),
          ),
        ),

        // Category 2-2-1 grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    child: _CategoryCard(
                      category: kNavTaxonomy[0],
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _CategoryCard(
                      category: kNavTaxonomy[1],
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: _CategoryCard(
                      category: kNavTaxonomy[2],
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _CategoryCard(
                      category: kNavTaxonomy[3],
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                _CategoryCard(
                  category: kNavTaxonomy[4],
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  fullWidth: true,
                ),
              ],
            ),
          ),
        ),

        // CTA Banner 1
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
          sliver: SliverToBoxAdapter(
            child: _buildCtaBanner(
              icon: Icons.local_offer_outlined,
              tag: 'Welcome Offer',
              headline: 'First Visit? Save 20%',
              body:
                  'New to MSD? Enjoy 20% off your first booking at any partner spa — discount applied automatically at checkout.',
              actionLabel: 'Book Your First Visit',
              containerColor: colorScheme.primaryContainer,
              onContainerColor: colorScheme.onPrimaryContainer,
            ),
          ),
        ),

        // Hot Right Now header
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Icon(Icons.local_fire_department_outlined,
                    color: colorScheme.error, size: 20),
                const SizedBox(width: 6),
                Expanded(
                    child: Text('Hot Right Now',
                        style: textTheme.titleLarge)),
                TextButton(onPressed: () {}, child: const Text('See all')),
              ],
            ),
          ),
        ),

        // Hot Deals carousel
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: CarouselView(
              itemExtent: 240,
              shrinkExtent: 160,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              onTap: (_) {},
              children: _hotDeals.map((deal) {
                return Card.filled(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE ZONE — Stack, height 100
                      Stack(
                        children: [
                          Image.asset(
                            deal.image,
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Positioned.fill(
                            child: ColoredBox(
                              color: colorScheme.primary.withValues(alpha: 0.20),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Chip(
                              label: Text(deal.tag),
                              labelStyle: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onErrorContainer),
                              backgroundColor: colorScheme.errorContainer,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              side: BorderSide.none,
                            ),
                          ),
                        ],
                      ),
                      // CONTENT ZONE
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(deal.title,
                                style: textTheme.titleSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text(deal.subtitle,
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // CTA Banner 2
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
          sliver: SliverToBoxAdapter(
            child: _buildCtaBanner(
              icon: Icons.card_giftcard_outlined,
              tag: 'Gift Cards',
              headline: 'Give the Gift of Wellness',
              body:
                  'Treat someone special to a spa experience. Gift cards from ₹500, valid at 200+ partner spas — never expire.',
              actionLabel: 'Send a Gift Card',
              containerColor: colorScheme.tertiaryContainer,
              onContainerColor: colorScheme.onTertiaryContainer,
            ),
          ),
        ),

        // Deals by category
        for (final category in _dealCategories) ...[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Icon(category.icon, size: 20, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(category.name,
                          style: textTheme.titleLarge)),
                  TextButton(
                      onPressed: () {}, child: const Text('See all')),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: category.deals.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final deal = category.deals[index];
                  return SizedBox(
                    width: 180,
                    child: Card.outlined(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // IMAGE ZONE — Stack, height 72
                            Stack(
                              children: [
                                Image.asset(
                                  deal.image,
                                  width: double.infinity,
                                  height: 72,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 6,
                                  right: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    child: Text(
                                      deal.price,
                                      style: textTheme.labelSmall?.copyWith(
                                        color:
                                            colorScheme.onSecondaryContainer,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // CONTENT ZONE
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 8, 12, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    deal.title,
                                    style: textTheme.titleSmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    deal.subtitle,
                                    style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.surfaceContainerLowest,
      drawer: const CategoryDrawer(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (i) => setState(() => _navIndex = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Explore'),
          NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon: Icon(Icons.calendar_today),
              label: 'Bookings'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
      body: _navIndex == 0
          ? _buildHomeBody(colorScheme, theme)
          : Center(
              child: Text(
                'Coming soon',
                style: textTheme.bodyLarge
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
    );
  }
}
