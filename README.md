# Github Notifier for Mac

A simple tool, which can notify you any new notification in Github.

With it, all your latest Github notifications will be notified by Notification Center, just like:

![](imgs/notification_1.png)

You can click it and go to the detail page.

## Dependencies

- Mac OS X at least Mountain Lion(>= 10.8)
- [terminal-notifier](https://github.com/alloy/terminal-notifier)

## Install

1. Download source code to one of your directories.
2. This project depends on [terminal-notifier](https://github.com/alloy/terminal-notifier),
execute this if you use [HomeBrew](http://brew.sh/)

  ```sh
  $ brew install terminal-notifier
  ```

3. Open the project directory in your terminal.
4. Execute

  ```sh
  $ ./github-notifier
  ```

  Will open personal access token setting panel.
5. You can generate new token, give it a name and only notifications permission:
  ![](imgs/tutorial_1.png)
6. Then you'll be given a token, copy it
  ![](imgs/tutorial_2.png)
7. Execute

  ```sh
  $ ./github-notifier <token>
  ```

  ![](imgs/tutorial_3.png)
8. Done.

# Uninstall

1. Execute

  ```sh
  $ launchctl unload ~/Library/LaunchAgents/git.bachue.githubnotifier.plist
  ```

2. Delete the project directory.
3. Done.

# Issue or Advice

Any issue or advice are appreciated, pull request will be better, of course!

# License

Released under the GPL v2 license
