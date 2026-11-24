import 'package:flutter/material.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const IntroScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final onColor = colorScheme.onPrimaryContainer;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Brand identity, vertically centered ---
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Badge: inverted from auth/otp — primary on primaryContainer bg
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(
                      Icons.spa_rounded,
                      size: 48,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'MSD',
                    style: textTheme.displaySmall?.copyWith(
                      color: onColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'MySpaDeal',
                    style: textTheme.titleMedium?.copyWith(
                      color: onColor.withValues(alpha: 0.65),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Taglines — each on its own line with room to breathe
                  Text(
                    'Get Deals.',
                    style: textTheme.bodyLarge?.copyWith(color: onColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Get Relaxed.',
                    style: textTheme.bodyLarge?.copyWith(color: onColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Pay Less.',
                    style: textTheme.bodyLarge?.copyWith(color: onColor),
                  ),
                ],
              ),
            ),

            // --- Loading indicator pinned to bottom ---
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: onColor,
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
