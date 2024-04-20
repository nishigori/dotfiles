// https://support.mozilla.org/kb/about-config-editor-firefox

user_pref("accessibility.typeaheadfind.enablesound", false);
user_pref("browser.autofocus", false);
user_pref("browser.ctrlTab.recentlyUsedOrder", false);
user_pref("browser.insertRelatedAfterCurrent", true);
// From https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#on-firefox-69-and-later
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// From https://addons.mozilla.org/ja/firefox/addon/simple-tab-groups/
user_pref("svg.context-properties.content.enabled", true);
// From trydactyl work on addons.mozilla.org
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);
// From trydactyl work on container tabs
user_pref("privacy.userContext.enabled", true);
