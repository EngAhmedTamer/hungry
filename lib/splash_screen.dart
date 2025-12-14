import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/core/widgets/glassmorphic_container.dart';
import 'package:hungry/features/auth/view/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _gradientController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation with spring effect
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Gradient animation
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _gradientController,
        curve: Curves.easeInOut,
      ),
    );

    // Particle animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _logoController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginView(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _gradientController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _gradientAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Color.lerp(
                          colorScheme.primary.withOpacity(0.9),
                          colorScheme.secondary.withOpacity(0.7),
                          _gradientAnimation.value,
                        )!,
                        Color.lerp(
                          colorScheme.secondary,
                          colorScheme.primary.withOpacity(0.8),
                          _gradientAnimation.value,
                        )!,
                        colorScheme.background,
                      ]
                    : [
                        Color.lerp(
                          colorScheme.primary,
                          colorScheme.secondary,
                          _gradientAnimation.value * 0.3,
                        )!,
                        Color.lerp(
                          colorScheme.secondary,
                          colorScheme.primary,
                          _gradientAnimation.value * 0.3,
                        )!,
                        Colors.white,
                      ],
              ),
            ),
            child: Stack(
              children: [
                // Floating particles
                ...List.generate(15, (index) {
                  return _FloatingParticle(
                    controller: _particleController,
                    index: index,
                    isDark: isDark,
                  );
                }),
                // Large floating shapes
                Positioned(
                  top: -100,
                  right: -100,
                  child: AnimatedBuilder(
                    animation: _particleController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _particleController.value * 2 * math.pi,
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: -150,
                  left: -150,
                  child: AnimatedBuilder(
                    animation: _particleController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: -_particleController.value * 2 * math.pi,
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Main logo
                Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                            BoxShadow(
                              color: colorScheme.secondary.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: GlassmorphicContainer(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(30),
                          borderRadius: BorderRadius.circular(30),
                          blur: 25.0,
                          borderWidth: 2.0,
                          borderColor: Colors.white.withOpacity(0.3),
                          child: SvgPicture.asset(
                            'assets/logo/logo.svg',
                            color: isDark ? Colors.white : colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FloatingParticle extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final bool isDark;

  const _FloatingParticle({
    required this.controller,
    required this.index,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final random = math.Random(index);
    final size = 4.0 + random.nextDouble() * 6.0;
    final startX = random.nextDouble();
    final startY = random.nextDouble();
    final duration = 3.0 + random.nextDouble() * 2.0;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final progress = (controller.value * duration) % 1.0;
        final x = startX * MediaQuery.of(context).size.width;
        final y = startY * MediaQuery.of(context).size.height +
            math.sin(progress * 2 * math.pi) * 50;

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: 0.3 + math.sin(progress * 2 * math.pi).abs() * 0.4,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
