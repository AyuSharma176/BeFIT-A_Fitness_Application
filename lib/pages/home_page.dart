import 'package:flutter/material.dart';
import 'package:befit/pages/app_theme.dart';

class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.appBarBg,
              AppTheme.backgroundColor,
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    Text(
                      'вє ƒιт',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        foreground: Paint()
                          ..color = Colors.black.withAlpha(153) // 0.6 opacity
                          ..maskFilter =
                          const MaskFilter.blur(BlurStyle.inner, 4),
                      ),
                    ),
                    Text(
                      'вє ƒιт',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(4, 4),
                            blurRadius: 8,
                            color: Colors.white.withAlpha(128),
                          ),
                          Shadow(
                            offset: Offset(-4, -4),
                            blurRadius: 8,
                            color: Colors.black.withAlpha(128),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Fit. Stay ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            color: Colors.white.withAlpha(102), // 0.4 opacity
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Lit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 25,
                            color: Colors.white,
                          ),
                          Shadow(
                            offset: Offset(-1, -1),
                            blurRadius: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '𝓦𝓮𝓵𝓬𝓸𝓶𝓮',
                      style: TextStyle(
                        color: AppTheme.drawerIconColor,
                        fontSize: 30,
                        shadows: [
                          Shadow(
                            offset: Offset(0,0),
                            blurRadius: 10,
                            color: AppTheme.appBarBg.withAlpha(167)
                          )
                        ]
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          AppTheme.appBarBg.withAlpha(160),
                        ],
                        stops: [0.3, 1]
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                      child: Text(
                        'Jatin Kumar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(3, 3),
                              blurRadius: 15,
                              color: Colors.white.withAlpha(100),

                            ),
                            Shadow(
                              offset: Offset(-2, -2),
                              blurRadius: 15,
                              color: AppTheme.appBarBg.withAlpha(140),
                            ),
                            Shadow(
                              offset: Offset(9, -13),
                              color: Colors.black,
                              blurRadius: 15,
                            )
                          ]// must be white or solid
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
