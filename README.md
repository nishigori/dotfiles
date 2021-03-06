Dotfiles
========

<!-- vim: set fdm=marker sts=0 expandtab: -->

```sh
$ git clone --recursive https://github.com/nishigori/dotfiles.git && cd dotfiles
$ make
$ make install
$ git remote set-url origin ssh://git@github.com:nishigori/dotfiles.git
```

----
Following docs is for the manually setup

<!-- TOC -->

- [MacOS](#macos)
  - [Alfread](#alfread)
- [Firefox](#firefox)
  - [`about:config`](#aboutconfig)
  - [Add-on: Tree Style Tab > Preferences](#add-on-tree-style-tab--preferences)
    - [Appearance:](#appearance)
    - [Tree Behavior](#tree-behavior)
  - [Add-on: Vim Vixen > Preferences](#add-on-vim-vixen--preferences)

<!-- /TOC -->

## MacOS

```sh
xcode-select --install
sudo xcodebuild -license accept
# for M1 Mac, needed rosetta
softwareupdate --install-rosetta
```

* Switch Ctrl <-> Caps Lock: `システム環境設定 > キーボード > 装飾キー`
* Disable Search man Page Index in Terminal `System Preferences > Keyboard > Shortcuts > Services`
  * Fix conflict for Intellij IDEA action of Find Action
* ⌘英かな: https://ei-kana.appspot.com/

## Alfread

always keyboard en: `Preferences > Advanced > Force Keyboard` to **ABC**

## Firefox

### `about:config`

* `browser.autofocus` to **false**
* `browser.ctrlTab.recentlyUsedOrder` to **false**
* `browser.tabs.insertRelatedAfterCurrent` to **true**
* `accessibility.typeaheadfind.enablesound` to **false**
* `toolkit.legacyUserProfileCustomizations.stylesheets` to **true**
  * from [treetabstyle wiki](https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#on-firefox-69-and-later)
* `svg.context-properties.content.enabled` to **true**
  * from [Simple Tab Groups](https://addons.mozilla.org/ja/firefox/addon/simple-tab-groups/)
* `privacy.resistFingerprinting.block_mozAddonManager` to **true**
  * from trydactyl work on addons.mozilla.org

### Hide Top tab-bar(s)

Reference of searching my-profile: https://support.mozilla.org/ja/kb/profiles-where-firefox-stores-user-data

```sh
# Example on Mac
$ cd ~/Library/Application\ Support/Firefox/Profiles/${YOUR_PROFILE}
$ mkdir -p chrome
$ cat <<EOT >> chrome/userChrome.css
/* https://github.com/doublejim/tree-style-tab-compact-dark-style */
@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");

#TabsToolbar {
  visibility: collapse;
}

#sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
  visibility: collapse;
}
EOT
```

### Add-on: Tree Style Tab > Preferences

`Unlock Expert Options` to `check-on`

#### Appearance:

* `Enable animation effects` to `check-off`
* `Too long label of tabs:` to select `Crop with "..." (Better Performance)`

#### Tree Behavior

* *all auto collapse options* to `check-off`
* `When a new tree appears, collapse others automatically` to `check-off`
* `When tab gets focus, expand its tree '` to ``

about:addons > Tre Style Tab > Preferences > Advanced:

<details>
<summary>Written at the custom-style-rules</summary>
<!-- {{{ -->
Ref: https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#for-version-2x

```css

/* https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#disable-all-animation */
@keyframes throbber {}
@keyframes tab-burst-animation {}
@keyframes tab-burst-animation-light {}
@keyframes blink {}

/* https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#highlight-active-tab*/
tab-item.active {
  height: 29px !important;
  background-color: #195599;
}
tab-item.active .label-content {
  font-weight: bold;
  font-size: 12px;
}
tab-item.active tab-twisty,
tab-item.active .label-content,
tab-item.active tab-counter {
  color: #fff;
}

/* https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#container-colored-underline-for-tab-2346 */
.contextual-identity-marker {
  top: auto !important;
  left: 0.5em !important;
  right: 0.5em !important;
  bottom: 0 !important;
  width: auto !important;
  max-width: none !important;
  height: calc(var(--favicon-size) / 10) !important;
}

/* https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#tab-numbering-and-counting */
#tabbar {
  counter-reset: vtabs atabs tabs;
  /* vtabs tracks visible tabs, atabs tracks active tabs, tabs tracks all tabs */
}
tab-item:not(.collapsed):not(.discarded) {
  counter-increment: vtabs atabs tabs;
}
tab-item:not(.collapsed) {
  counter-increment: vtabs tabs;
}
tab-item:not(.discarded) {
  counter-increment: atabs tabs;
}
tab-item {
  counter-increment: tabs;
}

/* https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#numbering-of-tabs-1601-2220 */
tab-item .extra-items-container {
  z-index: unset !important;
}
tab-item .extra-items-container::after {
  background: Highlight;
  color: HighlightText;
  content: counter(vtabs);
  font-size: x-small;
  right: 0.2em;
  padding: 0.2em;
  pointer-events: none;
  position: absolute;
  bottom: 0.2em;

  z-index: 1000;
}

/* https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#put-closebox-left-side-even-if-i-choose-left-side-style */
:root.left tab-item tab-twisty {
  order: 10000;
}
:root.left tab-item tab-closebox {
  order: -1;
}

```

<!-- }}} -->
</details>

### Add-on: Vim Vixen > Preferences

Configure Vim-Vixen:

<details>
<summary>Use plain JSON</summary>
<!-- {{{ -->

```json

{
  "keymaps": {
    "0": { "type": "scroll.home" },
    ":": { "type": "command.show" },
    ";": { "type": "command.show" },
    "<C-p>": { "type": "tabs.prev", "count": 1 },
    "<C-n>": { "type": "tabs.next", "count": 1 },
    "<C-k>": { "type": "navigate.history.prev" },
    "<C-j>": { "type": "navigate.history.next" },
    "o": { "type": "command.show.open", "alter": false },
    "O": { "type": "command.show.open", "alter": true },
    "t": { "type": "command.show.tabopen", "alter": false },
    "T": { "type": "command.show.tabopen", "alter": true },
    "b": { "type": "command.show.buffer" },
    "a": { "type": "command.show.addbookmark", "alter": true },
    "k": { "type": "scroll.vertically", "count": -4 },
    "j": { "type": "scroll.vertically", "count": 4 },
    "h": { "type": "scroll.horizonally", "count": -2 },
    "l": { "type": "scroll.horizonally", "count": 2 },
    "<C-U>": { "type": "scroll.pages", "count": -0.5 },
    "<C-D>": { "type": "scroll.pages", "count": 0.5 },
    "<C-B>": { "type": "scroll.pages", "count": -1 },
    "<C-F>": { "type": "scroll.pages", "count": 1 },
    "gg": { "type": "scroll.top" },
    "G": { "type": "scroll.bottom" },
    "$": { "type": "scroll.end" },
    "d": { "type": "tabs.close" },
    "D": { "type": "tabs.close", "select": "left" },
    "u": { "type": "tabs.reopen" },
    "K": { "type": "tabs.prev" },
    "J": { "type": "tabs.next" },
    "gT": { "type": "tabs.prev" },
    "gt": { "type": "tabs.next" },
    "g0": { "type": "tabs.first" },
    "g$": { "type": "tabs.last" },
    "r": { "type": "tabs.reload", "cache": false },
    "R": { "type": "tabs.reload", "cache": true },
    "zp": { "type": "tabs.pin.toggle" },
    "zd": { "type": "tabs.duplicate" },
    "zi": { "type": "zoom.in" },
    "zo": { "type": "zoom.out" },
    "zz": { "type": "zoom.neutral" },
    "f": { "type": "follow.start", "newTab": false },
    "F": { "type": "follow.start", "newTab": true, "background": false },
    "m": { "type": "mark.set.prefix" },
    "'": { "type": "mark.jump.prefix" },
    "H": { "type": "navigate.history.prev" },
    "L": { "type": "navigate.history.next" },
    "[[": { "type": "navigate.link.prev" },
    "]]": { "type": "navigate.link.next" },
    "gu": { "type": "navigate.parent" },
    "gU": { "type": "navigate.root" },
    "gi": { "type": "focus.input" },
    "gf": { "type": "page.source" },
    "gh": { "type": "page.home" },
    "gH": { "type": "page.home", "newTab": true },
    "y": { "type": "urls.yank" },
    "p": { "type": "urls.paste", "newTab": false },
    "P": { "type": "urls.paste", "newTab": true },
    "/": { "type": "find.start" },
    "n": { "type": "find.next" },
    "N": { "type": "find.prev" },
    ".": { "type": "repeat.last" },
    "<S-Esc>": { "type": "addon.toggle.enabled" }
  },
  "search": {
    "default": "google",
    "engines": {
      "google": "https://google.com/search?q={}",
      "twitter": "https://twitter.com/search?q={}",
      "wikipedia": "https://en.wikipedia.org/w/index.php?search={}"
    }
  },
  "properties": {
    "hintchars": "fjdkslieow",
    "smoothscroll": true,
    "complete": "sbh"
  },
  "blacklist": [
    "*.slack.com",
    "mail.google.com"
  ]
}

```

<!-- }}} -->
</details>
