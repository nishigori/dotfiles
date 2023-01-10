Dotfiles
========

<!-- vim: set fdm=marker sts=0 expandtab: -->

[![macos](https://github.com/nishigori/dotfiles/actions/workflows/macos.yml/badge.svg)](https://github.com/nishigori/dotfiles/actions/workflows/macos.yml)

```sh
$ make
$ make install
```

----

Following docs is for manually setup

<details>
    <summary>Mac OS</summary>

* Switch Ctrl <-> Caps Lock: `System Preferences > Keyboard > Modifier Keys...`
* Disable Search man Page Index in Terminal `System Preferences > Keyboard > Shortcuts > Services`
    * Fix conflict for Intellij IDEA action of Find Action
* ⌘英かな: https://ei-kana.appspot.com/ (not managed by homebrew)

</details>

<details>
    <summary>Alfread</summary>

* always keyboard en: `Preferences > Advanced > Force Keyboard` to **ABC**
* `Appearance > Options > Show Alfred on` **mouse screen** or **active screen**

</details>

<details><summary>Firefox</summary><blockquote>

<details><summary>about:config</summary><blockquote>

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

</blockquote></details>

<details><summary>Hide Top tab-bar(s)</summary><blockquote>

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

</blockquote></details>

<details><summary>Add-on: Most Recent Tab > Preferences</summary><blockquote>

Keyboard shortcut: `MacCtrl+9` (<C-,>) as switch back to recently selected tab.

</blockquote></details>

<details><summary>Add-on: Tree Style Tab > Preferences</summary><blockquote>

`Unlock Expert Options` to `check-on`

### Appearance:
* `Enable animation effects` to `check-off`
* `Too long label of tabs:` to select `Crop with "..." (Better Performance)`

### Tree Behavior:

* *all auto collapse options* to `check-off`
* `When a new tree appears, collapse others automatically` to `check-off`
* `When tab gets focus, expand its tree '` to ``

### Advanced:

custom-style-rules (https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#for-version-2x)

<!-- {{{ -->
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

</blockquote></details>

</blockquote></detials><!-- fin firefox -->
