# FetchRequest bug
There is an inconsistency when using FetchRequest and CoreData in SwiftUI. Sometimes changes to an item are reflected properly, and other times the changes are not shown.

1. Launching the app for the first time, then creating an item, then pressing the 'add' button __works as expected__.
2. re-launching (build in xcode or kill and re-launch) the app,, and pressing the "add" button on any item works only once, then __does not show changes__.
3. If you add a new item, things __work as expected again__: New item is shown, all changes already made are shown, and any further changes with 'add' work.
The behavior is the same on a real iPhone 16 with iOS 26, iPhone 16 simulator with iOS 26, and an iPhone 16 simulator with iOS 18
