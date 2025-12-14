import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/core/widgets/glassmorphic_container.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/view/signup_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/snackBar_custom.dart';
import '../../../core/network/api_error.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  
  bool isLoading = false;
  bool obscurePassword = true;
  bool emailHasError = false;
  bool passwordHasError = false;
  
  late AnimationController _buttonController;
  late AnimationController _gradientController;
  late AnimationController _shakeController;
  late AnimationController _eyeController;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _gradientAnimation;
  late Animation<double> _shakeAnimation;
  late Animation<double> _eyeAnimation;
  
  AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    emailController.text = 'ahmed@gmail.com';
    passwordController.text = '123456789';
    
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );
    
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _gradientAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.easeInOut),
    );
    
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticOut),
    );
    
    _eyeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _eyeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _eyeController, curve: Curves.easeInOut),
    );
    
    emailFocus.addListener(() => setState(() {}));
    passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    _buttonController.dispose();
    _gradientController.dispose();
    _shakeController.dispose();
    _eyeController.dispose();
    super.dispose();
  }

  void _shakeError() {
    _shakeController.forward(from: 0.0).then((_) {
      _shakeController.reverse();
    });
  }

  Future<void> login() async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      _shakeError();
      return;
    }
    setState(() {
      isLoading = true;
      emailHasError = false;
      passwordHasError = false;
    });

    try {
      final user = await authRepo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (user != null && mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Root(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        String errorMsg = 'unknown error';
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      setState(() => emailHasError = true);
      return null; // Let the field handle empty validation
    }
    if (!value.contains('@') || !value.contains('.')) {
      setState(() => emailHasError = true);
      return 'Please enter a valid email';
    }
    setState(() => emailHasError = false);
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      setState(() => passwordHasError = true);
      return null;
    }
    if (value.length < 6) {
      setState(() => passwordHasError = true);
      return 'Password must be at least 6 characters';
    }
    setState(() => passwordHasError = false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                  // Floating background shapes
                  Positioned(
                    top: -80,
                    right: -80,
                    child: AnimatedBuilder(
                      animation: _gradientController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _gradientController.value * 2 * math.pi,
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
                    bottom: -120,
                    left: -120,
                    child: AnimatedBuilder(
                      animation: _gradientController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: -_gradientController.value * 2 * math.pi,
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
                  // Main content
                  SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              GlassmorphicContainer(
                                width: 120,
                                height: 120,
                                padding: const EdgeInsets.all(20),
                                borderRadius: BorderRadius.circular(25),
                                child: SvgPicture.asset(
                                  'assets/logo/logo.svg',
                                  color: isDark ? Colors.white : colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                'Welcome Back',
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sign in to continue',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 50),
                              AnimatedBuilder(
                                animation: _shakeAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      _shakeAnimation.value * math.sin(_shakeAnimation.value * 10),
                                      0,
                                    ),
                                    child: GlassmorphicContainer(
                                      padding: const EdgeInsets.all(24),
                                      borderRadius: BorderRadius.circular(24),
                                      child: Column(
                                        children: [
                                          // Email field with floating label
                                          _FloatingLabelTextField(
                                            controller: emailController,
                                            focusNode: emailFocus,
                                            label: 'Email Address',
                                            icon: CupertinoIcons.mail,
                                            keyboardType: TextInputType.emailAddress,
                                            validator: _validateEmail,
                                            hasError: emailHasError,
                                            isDark: isDark,
                                            colorScheme: colorScheme,
                                          ),
                                          const SizedBox(height: 24),
                                          // Password field with floating label
                                          _FloatingLabelTextField(
                                            controller: passwordController,
                                            focusNode: passwordFocus,
                                            label: 'Password',
                                            icon: CupertinoIcons.lock,
                                            obscureText: obscurePassword,
                                            onToggleObscure: () {
                                              setState(() {
                                                obscurePassword = !obscurePassword;
                                              });
                                              _eyeController.forward(from: 0.0).then((_) {
                                                _eyeController.reverse();
                                              });
                                            },
                                            eyeController: _eyeController,
                                            validator: _validatePassword,
                                            hasError: passwordHasError,
                                            isDark: isDark,
                                            colorScheme: colorScheme,
                                          ),
                                          const SizedBox(height: 12),
                                          // Forgot password link
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: _AnimatedLink(
                                              text: 'Forgot password?',
                                              onTap: () {
                                                // Handle forgot password
                                              },
                                              colorScheme: colorScheme,
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          // Login button
                                          GestureDetector(
                                            onTapDown: (_) => _buttonController.forward(),
                                            onTapUp: (_) {
                                              _buttonController.reverse();
                                              login();
                                            },
                                            onTapCancel: () => _buttonController.reverse(),
                                            child: AnimatedBuilder(
                                              animation: _buttonScaleAnimation,
                                              builder: (context, child) {
                                                return Transform.scale(
                                                  scale: _buttonScaleAnimation.value,
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 56,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          colorScheme.primary,
                                                          colorScheme.secondary,
                                                        ],
                                                      ),
                                                      borderRadius: BorderRadius.circular(16),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: colorScheme.primary
                                                              .withOpacity(0.5),
                                                          blurRadius: 20,
                                                          spreadRadius: 2,
                                                          offset: const Offset(0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: isLoading
                                                          ? const SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child: CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                      Colors.white,
                                                                    ),
                                                              ),
                                                            )
                                                          : Text(
                                                              'Login',
                                                              style: GoogleFonts.inter(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                              // Sign up link
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation, secondaryAnimation) =>
                                              const SignupView(),
                                      transitionsBuilder: (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOutCubic,
                                          )),
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(
                                        milliseconds: 400,
                                      ),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: isDark ? Colors.white70 : Colors.black54,
                                    ),
                                    children: [
                                      const TextSpan(text: "Don't have an account? "),
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: GoogleFonts.inter(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
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
      ),
    );
  }
}

class _FloatingLabelTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final AnimationController? eyeController;
  final String? Function(String?)? validator;
  final bool hasError;
  final bool isDark;
  final ColorScheme colorScheme;

  const _FloatingLabelTextField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.onToggleObscure,
    this.eyeController,
    this.validator,
    required this.hasError,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  State<_FloatingLabelTextField> createState() =>
      _FloatingLabelTextFieldState();
}

class _FloatingLabelTextFieldState extends State<_FloatingLabelTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _labelController;
  late Animation<double> _labelAnimation;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.isNotEmpty;
    _labelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _labelAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _labelController, curve: Curves.easeOut),
    );
    if (_hasText || widget.focusNode.hasFocus) {
      _labelController.value = 1.0;
    }
    widget.focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
  }

  void _onFocusChange() {
    if (widget.focusNode.hasFocus || _hasText) {
      _labelController.forward();
    } else {
      _labelController.reverse();
    }
  }

  void _onTextChange() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
      if (hasText || widget.focusNode.hasFocus) {
        _labelController.forward();
      } else {
        _labelController.reverse();
      }
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassmorphicContainer(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
            TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            validator: widget.validator,
            style: GoogleFonts.inter(
              color: widget.isDark ? Colors.white : Colors.black87,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: widget.label,
              hintStyle: GoogleFonts.inter(
                color: widget.isDark ? Colors.white38 : Colors.grey.shade400,
                fontSize: 12,
              ),
              contentPadding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 12,
              ),
              prefixIcon: Icon(
                widget.icon,
                color: widget.focusNode.hasFocus
                    ? widget.colorScheme.primary
                    : (widget.isDark ? Colors.white54 : Colors.grey.shade500),
              ),
              suffixIcon: widget.onToggleObscure != null
                  ? AnimatedBuilder(
                animation: widget.eyeController!,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + widget.eyeController!.value * 0.2,
                    child: GestureDetector(
                      onTap: widget.onToggleObscure,
                      child: Icon(
                        widget.obscureText
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: widget.isDark
                            ? Colors.white54
                            : Colors.grey.shade500,
                      ),
                    ),
                  );
                },
              )
                  : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),

              AnimatedBuilder(
                animation: _labelAnimation,
                builder: (context, child) {
                  return Positioned(
                    left: 50,
                    top: 8 + (1 - _labelAnimation.value) * 12,
                    child: Transform.scale(
                      scale: 0.75 + _labelAnimation.value * 0.25,
                      child: Opacity(
                        opacity: _labelAnimation.value,
                        child: Text(
                          widget.label,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: widget.focusNode.hasFocus
                                ? widget.colorScheme.primary
                                : (widget.isDark
                                    ? Colors.white54
                                    : Colors.grey.shade500),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        if (widget.hasError && widget.controller.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset((1 - value) * 10, 0),
                    child: Text(
                      widget.validator?.call(widget.controller.text) ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _AnimatedLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _AnimatedLink({
    required this.text,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  State<_AnimatedLink> createState() => _AnimatedLinkState();
}

class _AnimatedLinkState extends State<_AnimatedLink>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Text(
              widget.text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: widget.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
