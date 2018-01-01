/*
 * https://github.com/onivim/oni/wiki/Configuration
 */

const activate = (oni) => {
   // access the Oni plugin API here

   // for example, unbind the default `<c-p>` action:
   //oni.input.unbind("<c-p>")

   // or bind a new action:
   //oni.input.bind("<c-enter>", () => alert("Pressed control enter"));
};

module.exports = {
    activate,
    "oni.useDefaultConfig": true,
    "oni.loadInitVim": true,
    "editor.fontSize": "14px",
    "editor.fontFamily": "Ricty Discord",
    "editor.backgroundOpacity": 0.7,
    "editor.completions.enabled": true
}
