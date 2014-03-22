CivicSourcing.TaskItemComponent = Em.Component.extend

  task: null

  completed: (->
    @get("task.completed")
  ).property("task.completed")

  actions:
    toggleTask: ->
      newValue = if @get("completed") then false else true
      @get("task").set("completed", newValue).save()