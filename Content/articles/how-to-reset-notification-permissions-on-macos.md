---
title: How to reset notification permissions on macOS
description: Easily reset notification permissions during development to test your app as a new user without restarting your computer.
layout: article
publishedAt: 2022-05-16
---

While working on your app‘s notification permission flow it‘s helpful to be able to test it as a new user launching your app for the first time.

This is how you can reset the permissions back to [`UNAuthorizationStatus.notDetermined`](https://developer.apple.com/documentation/usernotifications/unauthorizationstatus/notdetermined):

1. Stop your app in Xcode if it‘s running: `⌘` + `.` or __Product__ > __Stop__
2. Remove your app from `DerivedData`: `open ~/Library/Developer/Xcode/DerivedData` and delete your app‘s folder(s)
3. Quit System Preferences if opened: `⌘` + `Q`, `killall System\ Preferences`, or stop the `System Preferences` process in __Activity Monitor__
4. Restart Notification Center: `killall NotificationCenter` or stop the `Notification Centre` process in __Activity Monitor__

Done! You can now run your app again and test the flow as a new user. No need to restart your computer.

## Bonus

If you have to do this a lot, here‘s a one-liner to remove your app from `DerivedData` and restart Notification Center:

```zsh
cd ~/Library/Developer/Xcode/DerivedData && rm -rf {YourProject}-??* && killall NotificationCenter
```

Remember to replace `{YourProject}` with your app‘s project name.
