import 'package:flutter/material.dart';
import 'auth_screen.dart';

class _Slide {
  final IconData icon;
  final String title;
  final String body;

  const _Slide({required this.icon, required this.title, required this.body});
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_Slide> _slides = [
    _Slide(
      icon: Icons.explore_outlined,
      title: 'Discover Spas',
      body:
          'Find top-rated spas and wellness centres near you with personalised recommendations.',
    ),
    _Slide(
      icon: Icons.calendar_month_outlined,
      title: 'Easy Booking',
      body:
          'Book appointments in seconds. No calls, no waiting — instant confirmation.',
    ),
    _Slide(
      icon: Icons.star_outline,
      title: 'Trusted Experts',
      body:
          'Every spa partner is verified. Read real reviews from real customers.',
    ),
    _Slide(
      icon: Icons.card_giftcard_outlined,
      title: 'Exclusive Deals',
      body: 'Unlock members-only prices and seasonal offers every week.',
    ),
  ];

  void _goToAuth() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isLast = _currentPage == _slides.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card.filled(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Icon(slide.icon,
                                  size: 96, color: colorScheme.primary),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            slide.title,
                            style: textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            slide.body,
                            style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurfaceVariant),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 8),
                    width: i == _currentPage ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _currentPage
                          ? colorScheme.primary
                          : colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () {
                        if (!isLast) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _goToAuth();
                        }
                      },
                      child: Text(isLast ? 'Get Started' : 'Next'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isLast)
            Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: TextButton(
                  onPressed: _goToAuth,
                  child: const Text('Skip'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
