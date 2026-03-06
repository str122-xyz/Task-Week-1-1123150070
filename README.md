# Fruit Catcher: Flutter & Flame Game Engine

Game Fruit Catcher adalah sebuah permainan arkade kasual 2D yang dikembangkan menggunakan framework Flutter dan *game engine* Flame. Proyek ini mendemonstrasikan integrasi yang solid antara UI Flutter *native* dengan sistem *canvas rendering* dari Flame, menjadikannya fondasi yang sangat baik untuk mempelajari dasar-dasar pengembangan *mobile game*.

## 🌟 Fitur Utama

* **Gameplay Interaktif**: Pemain mengendalikan sebuah keranjang untuk menangkap berbagai jenis buah (Apel, Pisang, Jeruk, Stroberi) yang jatuh secara terus-menerus dari atas layar
* **State Management Lintas Engine**: Menggunakan `ValueNotifier` dan `ValueListenableBuilder` untuk menjembatani perubahan skor *real-time* dari dalam logika Flame ke elemen UI (teks) di layer Flutter tanpa perlu me- *rebuild* seluruh layar
* **Kontrol Sentuh Presisi (Pan/Drag)**: Memanfaatkan `PanDetector` bawaan Flame untuk mendeteksi pergerakan jari (drag). Posisi keranjang juga dijaga tetap berada di dalam layar menggunakan perhitungan *clamping*
* **Sistem Spawner Otomatis**: Buah-buahan dimunculkan (*spawn*) pada koordinat sumbu X yang diacak menggunakan fungsi `Random().nextDouble()`, dengan interval waktu konstan setiap 1,5 detik
* **Manajemen Audio Terpusat**: Menerapkan pola desain *Singleton* pada *class* `AudioManager`. Kelas ini memastikan pemuatan awal (*preload*), pengaturan volume, serta pemutaran *Background Music* (BGM) dan *Sound Effects* (SFX) berjalan efisien tanpa tumpang tindih

## 📂 Arsitektur & Struktur Direktori

Proyek ini mengadopsi pemisahan tanggung jawab (*separation of concerns*) yang jelas antara logika *engine*, komponen objek, pengelola aset, dan tampilan antarmuka:

```text
lib/
├── main.dart                   # Entry point aplikasi, inisialisasi AudioManager, dan layout Overlay (Stack)
├── managers/
│   └── audio_manager.dart      # Singleton pattern pengelola BGM dan SFX
└── game/
    ├── fruit_catcher_game.dart # Core logic FlameGame (Kamera, Collision Detection, Timer)
    └── components/
        ├── basket.dart         # Entitas keranjang (Player) yang dirender manual via Canvas
        └── fruit.dart          # Entitas buah jatuh dengan deteksi tabrakan (CollisionCallbacks)
```

## 🛠️ Persyaratan Sistem & Dependensi

Untuk menjalankan proyek ini, pastikan Anda telah menginstal Flutter SDK. `cite_start` Dependensi utama yang diatur pada berkas `pubspec.yaml` meliputi.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flame: ^1.17.0       # Engine utama untuk loop, physics, rendering, dan collision
  flame_audio: ^2.1.6  # Modul audio yang dioptimalkan untuk performa game
```

## 🎨 Aset Visual & Audio

Berbeda dari game 2D pada umumnya yang menggunakan *sprite image*, komponen visual game ini (keranjang dan buah) dirender secara prosedural langsung di atas memori menggunakan `Canvas` dan `Paint` bawaan Flutter (seperti efek warna dan *shine* pada buah)

Namun, aplikasi mutlak memerlukan file audio untuk menghidupkan suasana. Pastikan direktori ini terdaftar di `pubspec.yaml`
* `assets/audio/music/background_music.mp3` : Musik latar saat bermain
* `assets/audio/sfx/collect.mp3` : Suara ketika keranjang berhasil menangkap buah
* `assets/audio/sfx/explosion.mp3` : Suara pemicu kondisi *Game Over*
* `assets/audio/sfx/jump.mp3` : Aset SFX tambahan

## ⚙️ Logika Inti (Under the Hood)

1. **Sistem Viewport**: Game ini menjaga rasio layar tetap stabil dengan `FixedResolutionViewport` pada resolusi `400x800` agar proporsi arena permainan tidak rusak di berbagai ukuran *device*
2. **Integrasi UI Layering**: Melalui *widget* `Stack` di `main.dart`, antarmuka Flutter biasa (`Positioned` teks skor di kiri dan tombol mute di kanan) diposisikan melayang dengan sempurna tepat di atas komponen `GameWidget(game: game)` milik Flame.
3. **Deteksi Tabrakan (Collision)**: Setiap buah turun secara vertikal dengan kecepatan tetap (200 piksel/detik) Jika komponen dengan `CircleHitbox` (buah) bersinggungan dengan `RectangleHitbox` milik keranjang, sistem akan otomatis memanggil `gameRef.incrementScore()` dan menghancurkan objek buah tersebut dari memori layar.

## 🚀 Panduan Instalasi & Eksekusi

1. **Clone repositori proyek ini**:
   ```bash
   git clone <url-repositori-github>
   cd fruit-catcher-game
   ```
2. **Sinkronisasi dependensi Flutter**:
   ```bash
   flutter pub get
   ```
3. **Persiapan Audio**: Masukkan file `.mp3` pendukung sesuai pada pohon direktori `assets/audio/...`
4. **Kompilasi dan Jalankan**:
   ```bash
   flutter run
   ```

## 🎮 Cara Bermain
1. Usap dan geser keranjang ke kiri atau kanan untuk bergerak
2. Tangkap seluruh buah untuk mendulang skor
3. Anda bisa kapan saja menyalakan atau mematikan musik latar (🎵) maupun efek suara (🔊) lewat tombol di kanan atas layar