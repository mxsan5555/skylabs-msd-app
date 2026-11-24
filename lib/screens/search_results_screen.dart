import 'package:flutter/material.dart';
import '../shared/utils/deal_images.dart';

// ---------------------------------------------------------------------------
// Private data models
// ---------------------------------------------------------------------------

class _FilterGroup {
  final String name;
  final IconData icon;
  final List<String> options;
  const _FilterGroup(this.name, this.icon, this.options);
}

class _SearchDeal {
  final String name;
  final String category;
  final String about;
  final String image;
  final String price;
  final String distance;
  final String rating;
  final bool isOpen;

  const _SearchDeal({
    required this.name,
    required this.category,
    required this.about,
    required this.image,
    required this.price,
    required this.distance,
    required this.rating,
    required this.isOpen,
  });
}

// ---------------------------------------------------------------------------

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final Set<String> _activeFilters = {};

  static const _filterGroups = [
    _FilterGroup(
      'Price',
      Icons.payments_outlined,
      [r'$ — Budget', r'$$ — Mid-range', r'$$$ — Premium', r'$$$$ — Luxury'],
    ),
    _FilterGroup(
      'Suggested',
      Icons.recommend_outlined,
      [
        'Best Deal',
        'Top Rated',
        'Most Popular',
        'New Arrival',
        'Accepts Cards',
        'Open Now',
      ],
    ),
    _FilterGroup(
      'Category',
      Icons.category_outlined,
      [
        'Day Spa',
        'Massage',
        'Facial',
        'Body Wrap',
        'Nail Care',
        'Hair & Beauty',
        'Waxing',
        'Meditation',
      ],
    ),
    _FilterGroup(
      'Features',
      Icons.tune_outlined,
      [
        'Open Now',
        'Couples Package',
        'Gift Cards',
        'Parking',
        'Home Service',
        'Women Only',
        'Membership',
        'Wheelchair Access',
      ],
    ),
    _FilterGroup(
      'Distance',
      Icons.near_me_outlined,
      [
        'Under 1 km',
        '1 – 3 km',
        '3 – 5 km',
        '5 – 10 km',
        'Any distance',
      ],
    ),
  ];

  static final _deals = [
    _SearchDeal(
      name: 'Serenity Spa & Wellness',
      category: 'Day Spa',
      about: 'Signature massage, facial, and aromatherapy packages for complete mind-body relaxation.',
      image: kDealImages[0],
      price: r'$$',
      distance: '1.2 km',
      rating: '4.8',
      isOpen: true,
    ),
    _SearchDeal(
      name: 'Urban Massage Studio',
      category: 'Massage',
      about: 'Swedish, deep tissue, and Thai massage by certified therapists in a modern studio.',
      image: kDealImages[1],
      price: r'$',
      distance: '0.8 km',
      rating: '4.6',
      isOpen: true,
    ),
    _SearchDeal(
      name: 'Glow Skin Clinic',
      category: 'Facial',
      about: 'Medical-grade facials, chemical peels, and anti-aging treatments by skin specialists.',
      image: kDealImages[2],
      price: r'$$$',
      distance: '2.4 km',
      rating: '4.9',
      isOpen: false,
    ),
    _SearchDeal(
      name: 'The Nail Lounge',
      category: 'Nail Care',
      about: 'Gel manicures, spa pedicures, and nail art by trained nail artists.',
      image: kDealImages[3],
      price: r'$',
      distance: '0.5 km',
      rating: '4.5',
      isOpen: true,
    ),
    _SearchDeal(
      name: 'Zen Ayurveda Centre',
      category: 'Day Spa',
      about: 'Authentic Ayurvedic therapies including Abhyanga, Shirodhara, and Panchakarma.',
      image: kDealImages[4],
      price: r'$$$$',
      distance: '3.1 km',
      rating: '4.7',
      isOpen: true,
    ),
    _SearchDeal(
      name: 'Bloom Beauty Bar',
      category: 'Hair & Beauty',
      about: 'Full-service hair salon offering cuts, colour, treatments, and blowouts.',
      image: kDealImages[5],
      price: r'$$',
      distance: '1.8 km',
      rating: '4.4',
      isOpen: false,
    ),
    _SearchDeal(
      name: 'Lotus Wellness Spa',
      category: 'Day Spa',
      about: 'Premium spa offering couples packages, hot stone therapy, and private suites.',
      image: kDealImages[6],
      price: r'$$$',
      distance: '4.2 km',
      rating: '4.9',
      isOpen: true,
    ),
    _SearchDeal(
      name: 'Pure Balance Studio',
      category: 'Meditation',
      about: 'Guided meditation, sound healing, and mindfulness sessions for stress relief.',
      image: kDealImages[7],
      price: r'$',
      distance: '2.0 km',
      rating: '4.6',
      isOpen: true,
    ),
    _SearchDeal(
      name: 'Velvet Touch Wax Studio',
      category: 'Waxing',
      about: 'Full and half body waxing with premium quality wax and experienced therapists.',
      image: kDealImages[8],
      price: r'$',
      distance: '1.4 km',
      rating: '4.3',
      isOpen: true,
    ),
    _SearchDeal(
      name: 'The Stone Garden Spa',
      category: 'Massage',
      about: 'Specialist in hot stone, lava shell, and aromatherapy massage therapies.',
      image: kDealImages[9],
      price: r'$$$',
      distance: '5.6 km',
      rating: '4.8',
      isOpen: false,
    ),
  ];

  // -------------------------------------------------------------------------
  // Filter logic
  // -------------------------------------------------------------------------

  int _activeCountFor(_FilterGroup group) =>
      group.options.where(_activeFilters.contains).length;

  void _openFilterSheet(_FilterGroup group) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (_, setSheetState) {
            final textTheme = Theme.of(context).textTheme;
            final colorScheme = Theme.of(context).colorScheme;
            final active = group.options.where(_activeFilters.contains).toList();

            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(group.icon, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(group.name,
                              style: textTheme.titleLarge)),
                      if (active.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            setState(
                                () => group.options.forEach(_activeFilters.remove));
                            setSheetState(() {});
                          },
                          child: const Text('Clear'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: group.options.map((option) {
                      final selected = _activeFilters.contains(option);
                      return FilterChip(
                        label: Text(option),
                        selected: selected,
                        onSelected: (on) {
                          setState(() {
                            on
                                ? _activeFilters.add(option)
                                : _activeFilters.remove(option);
                          });
                          setSheetState(() {});
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => Navigator.pop(sheetCtx),
                    child: Text(
                      active.isEmpty
                          ? 'Show results'
                          : 'Apply ${active.length} filter${active.length == 1 ? '' : 's'}',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _clearAllFilters() => setState(() => _activeFilters.clear());

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasFilters = _activeFilters.isNotEmpty;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: colorScheme.surfaceContainerLowest,
            scrolledUnderElevation: 1,
            surfaceTintColor: colorScheme.primary,
            title: const Text('Search Results'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: SizedBox(
                height: 56,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    // "All filters" button with total active count
                    ActionChip(
                      avatar: Icon(
                        Icons.tune_outlined,
                        size: 18,
                        color: hasFilters
                            ? colorScheme.onSecondaryContainer
                            : null,
                      ),
                      label: Text(
                        hasFilters
                            ? 'Filters (${_activeFilters.length})'
                            : 'Filters',
                      ),
                      backgroundColor: hasFilters
                          ? colorScheme.secondaryContainer
                          : null,
                      onPressed: () => _openFilterSheet(_filterGroups.first),
                    ),
                    if (hasFilters) ...[
                      const SizedBox(width: 8),
                      ActionChip(
                        avatar: const Icon(Icons.close, size: 16),
                        label: const Text('Clear all'),
                        onPressed: _clearAllFilters,
                      ),
                    ],
                    const SizedBox(width: 8),
                    // One chip per filter group
                    for (final group in _filterGroups) ...[
                      _FilterGroupChip(
                        group: group,
                        activeCount: _activeCountFor(group),
                        onTap: () => _openFilterSheet(group),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Active filter chips (when filters are applied)
          if (hasFilters)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: _activeFilters.map((filter) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InputChip(
                        label: Text(filter),
                        onDeleted: () =>
                            setState(() => _activeFilters.remove(filter)),
                        deleteIcon: const Icon(Icons.close, size: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

          // Results count
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            sliver: SliverToBoxAdapter(
              child: Text(
                '${_deals.length} results',
                style: textTheme.labelLarge
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
          ),

          // Deal cards
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverList.separated(
              itemCount: _deals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) =>
                  _DealCard(deal: _deals[index]),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filter group chip
// ---------------------------------------------------------------------------

class _FilterGroupChip extends StatelessWidget {
  final _FilterGroup group;
  final int activeCount;
  final VoidCallback onTap;

  const _FilterGroupChip({
    required this.group,
    required this.activeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = activeCount > 0;

    return FilterChip(
      avatar: Icon(group.icon, size: 16),
      label: Text(
        isActive ? '${group.name} ($activeCount)' : group.name,
      ),
      selected: isActive,
      showCheckmark: false,
      onSelected: (_) => onTap(),
      selectedColor: colorScheme.secondaryContainer,
    );
  }
}

// ---------------------------------------------------------------------------
// Deal card
// ---------------------------------------------------------------------------

class _DealCard extends StatelessWidget {
  final _SearchDeal deal;

  const _DealCard({required this.deal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: image thumbnail + name + price
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      deal.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(deal.name,
                            style: textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        Text(deal.category,
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    deal.price,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                deal.about,
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              // Footer row: open status + rating + distance + book button
              Row(
                children: [
                  // Open / Closed chip
                  Chip(
                    label: Text(deal.isOpen ? 'Open' : 'Closed'),
                    avatar: Icon(
                      deal.isOpen
                          ? Icons.circle
                          : Icons.circle_outlined,
                      size: 10,
                      color: deal.isOpen
                          ? colorScheme.tertiary
                          : colorScheme.error,
                    ),
                    labelStyle: textTheme.labelSmall?.copyWith(
                      color: deal.isOpen
                          ? colorScheme.tertiary
                          : colorScheme.error,
                    ),
                    side: BorderSide.none,
                    backgroundColor: deal.isOpen
                        ? colorScheme.tertiaryContainer
                        : colorScheme.errorContainer,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const SizedBox(width: 8),
                  // Rating
                  Icon(Icons.star_rounded,
                      size: 16, color: colorScheme.primary),
                  const SizedBox(width: 2),
                  Text(deal.rating, style: textTheme.labelMedium),
                  const SizedBox(width: 8),
                  // Distance
                  Icon(Icons.near_me_outlined,
                      size: 14, color: colorScheme.onSurfaceVariant),
                  const SizedBox(width: 2),
                  Text(deal.distance,
                      style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant)),
                  const Spacer(),
                  // Book button
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16)),
                    onPressed: () {},
                    child: const Text('Book'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
