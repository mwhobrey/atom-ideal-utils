IdealUtils = require '../lib/ideal-utils'

describe 'IdealUtils', ->
  [workspaceElement, activationPromise, editor] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('ideal-utils')

    waitsForPromise ->
      atom.workspace.open().then (e) ->
        editor = e

  describe 'when the ideal-utils:wrapSQLDotAdd event is triggered', ->
    it "wraps selected text with .Add('');", ->
      waitsForPromise ->
        return activationPromise

      runs ->
        editor.insertText 'Test Text'
        editor.selectAll()
        old_text = editor.getSelectedText()
        atom.commands.dispatch(workspaceElement, 'ideal-utils:wrapSQLDotAdd')
        editor.selectAll()
        new_text = editor.getSelectedText()
        expect(editor.getText()).toBe(".Add(' Test Text ');")

    it "wraps selected text with .Add('') spanning multi lines with +", ->
      waitsForPromise ->
        return activationPromise

      runs ->
        editor.insertText 'Test\nText'
        editor.selectAll()
        old_text = editor.getSelectedText()
        atom.commands.dispatch(workspaceElement, 'ideal-utils:wrapSQLDotAdd')
        editor.selectAll()
        new_text = editor.getSelectedText()
        expect(editor.getText()).toBe(".Add(' Test ' +\n' Text ');")

    it "wraps selected text with .Add('') spanning multiple lines with + but does not go beyond the selection", ->
      waitsForPromise ->
          return activationPromise

      runs ->
        editor.insertText 'Test\nMultiline\nText'
        editor.setCursorBufferPosition([0,0])
        editor.selectDown(1)
        editor.selectToEndOfLine()
        old_text = editor.getText()
        console.log old_text
        atom.commands.dispatch(workspaceElement, 'ideal-utils:wrapSQLDotAdd')
        editor.selectAll()
        expected_text = ".Add(' Test ' + \n' Multiline ');\nText"
        console.log expected_text
        new_text = editor.getSelectedText()
        console.log new_text
        expect(editor.getText()).toBe(".Add(' Test ' + \n' Multiline ');\nText")

  describe 'when the ideal-utils:wrapSQLForUpdate event is triggered', ->
    it "wraps selected text with Add('')", ->
      waitsForPromise ->
        return activationPromise

      runs ->
        editor.insertText 'Test Text'
        editor.selectAll()
        old_text = editor.getSelectedText()
        atom.commands.dispatch(workspaceElement, 'ideal-utils:wrapSQLForUpdate')
        editor.selectAll()
        new_text = editor.getSelectedText()
        expect(editor.getText()).toBe("Add(' Test Text ');")

    it "wraps selected text with Add('') spanning multi lines with +", ->
      waitsForPromise ->
        return activationPromise

      runs ->
        editor.insertText 'Test\nText'
        editor.selectAll()
        old_text = editor.getSelectedText()
        atom.commands.dispatch(workspaceElement, 'ideal-utils:wrapSQLForUpdate')
        editor.selectAll()
        new_text = editor.getSelectedText()
        expect(editor.getText()).toBe("Add(' Test ' +\n' Text ');")

    it "wraps selected text with Add('') spanning multiple lines with + but does not go beyond the selection", ->
      waitsForPromise ->
          return activationPromise

      runs ->
        editor.insertText 'Test\nMultiline\nText'
        editor.setCursorBufferPosition([0,0])
        editor.selectDown(1)
        editor.selectToEndOfLine()
        old_text = editor.getText()
        console.log old_text
        atom.commands.dispatch(workspaceElement, 'ideal-utils:wrapSQLDotAdd')
        editor.selectAll()
        expected_text = "Add(' Test ' + \n' Multiline ');\nText"
        console.log expected_text
        new_text = editor.getSelectedText()
        console.log new_text
        expect(editor.getText()).toBe("Add(' Test ' + \n' Multiline ');\nText")
