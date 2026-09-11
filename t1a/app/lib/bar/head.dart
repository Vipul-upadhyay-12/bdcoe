import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBackTap;

  const CustomAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = true,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    final double hHeight = 240;

    return ClipRect(
      child: Container(
        height: hHeight,
        width: double.infinity,
        color: Color(0xFF0F1A24),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: 245,
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 42, 58, 68).withValues(alpha: 0.6)
                ),
              ),
            ),
            Positioned(
              top: -100,
              right: 290,
              child: Container(
                height: 320,
                width: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 44, 65, 77).withValues(alpha: 0.8)
                ),
              ),
            ),
            if (showBackButton)
              Positioned(
                top: 0,
                left: 16,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 16,
                        ),
                        onPressed: onBackTap ?? () => Navigator.maybePop(context),
                      ),
                    ),
                  ),
                ),
              ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      
                    ),
                    SizedBox(height: 12,),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}