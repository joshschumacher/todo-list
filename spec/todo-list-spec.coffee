TodoList = require '../lib/todo-list'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TodoList", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('todo-list')

  describe "when the todo-list:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      jasmine.attachToDOM(workspaceElement)
      expect(workspaceElement.querySelector('.todo-list')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'todo-list:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.todo-list')).toExist()
        atom.commands.dispatch workspaceElement, 'todo-list:toggle'
        expect(workspaceElement.querySelector('.todo-list')).not.toExist()
