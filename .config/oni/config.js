/*
 * https://github.com/onivim/oni/wiki/Configuration
 */

const activate = (oni) => {
   // access the Oni plugin API here

    oni.input.bind("<Space>s", "vcs.sidebar.toggle")

   // for example, unbind the default `<c-p>` action:
   //oni.input.unbind("<c-p>")

   // or bind a new action:
   //oni.input.bind("<c-enter>", () => alert("Pressed control enter"));
};

module.exports = {
    activate,
    "environment.additionalPaths": [
        "/usr/local/opt/curl/bin/curl",
        "/usr/local/opt/libressl/bin",
        "/usr/local/opt/pyenv/shims",
        "/usr/local/opt/rbenv/shims",
        "/usr/local/opt/rbenv/bin",
        "/usr/local/opt/sqlite/bin",
        "~/.zplug/bin",
        //"~/.composer/vendor/bin",
        "~/.nodebrew/current/bin",
        //"~/.plenv/shims",
        //"~/google-cloud-sdk/bin",
        "~/bin",
        "/usr/local/bin",
        "/usr/bin",
        "/bin",
    ],

    // change configuration values here:
    //"oni.useDefaultConfig": true,
    "oni.loadInitVim": true,
    "oni.hideMenu": true,
    "editor.fontSize": "12px",
    "editor.fontFamily": "Ricty Discord",
    "editor.backgroundOpacity": 0.7,
    "editor.completions.enabled": true,
    "editor.cursorColumn": true,
    "editor.cursorColumnOpacity": 0.5,
    "autoUpdate.enabled": true,
    "sidebar.default.open": false,
    "experimental.vcs.sidebar": true
    "tabs.width": "60em",
    "tabs.wrap": false,

    "autoClosingPairs.enabled": true,
    "autoClosingPairs.default": [
        { "open": "{", "close": "}" },
        { "open": "[", "close": "]" },
        { "open": "(", "close": ")" },
    ],
}
