# Just Audio and Audio Service
-keep class com.ryanheise.** { *; }
-keep class com.google.android.exoplayer2.** { *; }
-keepclassmembers class * {
    @com.google.android.exoplayer2.** *;
}
-keepattributes *Annotation*

# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }

# Prevent obfuscation of Dart entry points
-keep class org.labatalladelafe.radioven1055.MainActivity { *; }

# WorkManager/ForegroundService (si los usas)
-keep class androidx.work.impl.** { *; }

# Otros posibles necesarios
-keep class android.support.v4.media.** { *; }
-keep class androidx.media.** { *; }