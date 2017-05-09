var richeditor = {};
var editor = document.getElementById("editor");

richeditor.insertText = function(text) {
    editor.innerHTML = text;
    window.webkit.messageHandlers.heightDidChange.postMessage(document.body.offsetHeight);
}

editor.addEventListener("input", function() {
    window.webkit.messageHandlers.textDidChange.postMessage(editor.innerHTML);
}, false)

document.addEventListener("selectionchange", function() {
    window.webkit.messageHandlers.heightDidChange.postMessage(document.body.offsetHeight);
}, false);

window.webkit.messageHandlers.heightDidChange.postMessage(document.body.offsetHeight);
