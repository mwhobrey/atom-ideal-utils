'use babel';

import { CompositeDisposable } from 'atom';
import { TextBuffer } from 'atom';

export default {
  subscriptions: null,

  activate(state) {

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'ideal-utils:wrapSQLForUpdate': () => this.wrapSQLForUpdate()
    }));

    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'ideal-utils:wrapSQLDotAdd': () => this.wrapSQLDotAdd()
    }));
  },

  wrapSQLForUpdate(){
    console.log('Wrapping SQL statement for update file.');
    editor = atom.workspace.getActiveTextEditor();
    buff = editor.getBuffer();

    if (buff.getLineCount() == 1) {
      editor.insertText("Add(' " + editor.getSelectedText() + " ');");
    }
    else {
      buff = new TextBuffer(editor.getSelectedText());
      new_text = '';
      for (var i = 0; i < buff.getLineCount(); i++) {
        var l = buff.lineForRow(i);

        if (i == 0) {
          l = "Add(' " + l + " ' +\n";
        }
        else if (i == buff.getLineCount() - 1) {
          l = "' " + l + " ');";
        }
        else {
          l = "' " + l + " ' +\n";
        }
        new_text += l;
      }
      editor.insertText(new_text);
    }
  },

  wrapSQLDotAdd(){
    console.log('Wrapping SQL statement for use with SQL.Add.');
    editor = atom.workspace.getActiveTextEditor();
    buff = editor.getBuffer();

    if (buff.getLineCount() == 1) {
      editor.insertText(".Add(' " + editor.getSelectedText() + " ');");
    }
    else {
      buff = new TextBuffer(editor.getSelectedText());
      new_text = '';
      for (var i = 0; i < buff.getLineCount(); i++) {
        var l = buff.lineForRow(i);

        if (i == 0) {
          l = ".Add(' " + l + " ' +\n";
        }
        else if (i == buff.getLineCount() - 1) {
          l = "' " + l + " ');";
        }
        else {
          l = "' " + l + " ' +\n";
        }
        new_text += l;
      }
      editor.insertText(new_text);
    }
  }

};
