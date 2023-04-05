# This is the rules file which prevents `proguard` from aggressively
# removing the classes which appear to be unused, in release mode.
#
# Since JNI is based on runtime lookup for classes, proguard will not have
# a way to know EmojiCompat class in our example is actually used. Therefore
# we have to explicitly list it in this file to prevent the application from
# crashing with ClassNotFoundException.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

-keep class androidx.emoji2.text.EmojiCompat { public *; }
