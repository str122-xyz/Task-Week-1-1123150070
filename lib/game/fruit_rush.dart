import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruit_rush/game/components/basket.dart';
import 'package:fruit_rush/game/components/fruit.dart';
import 'package:fruit_rush/managers/audio_manager.dart';

class FruitRush extends FlameGame with PanDetector, HasCollisionDetection {
  late Basket basket;
  final Random random = Random();
  double fruitSpawnTimer = 0;
  final double fruitSpawnInterval = 1.5;

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  int _score = 0;

  int get score => _score;
  set score(int value) {
    _score = value;
    scoreNotifier.value = value;
  }

  void resetScore() {
    _score = 0;
    scoreNotifier.value = 0;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(resolution: Vector2(400, 800));

    basket = Basket();
    await add(basket);

    AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);
    fruitSpawnTimer += dt;
    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    basket.position.x += info.delta.global.x;
    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  void incrementScore() {
    score++;
    AudioManager().playSfx('cash.mp3');
  }

  void gameOver() {
    AudioManager().playSfx('lose2.mp3');
    pauseEngine();
    overlays.add('GameOver');
  }

  @override
  void onRemove() {
    AudioManager().stopBackgroundMusic();
    super.onRemove();
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7), Color(0xFF0288D1)],
      ).createShader(rect);

    canvas.drawRect(rect, paint);

    super.render(canvas);
  }
}
