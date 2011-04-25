module TasksHelper
  def extend_task_link(task)
    link_to task.description, task_path(task), :remote => true, "data-output-mode" => "extend"
  end
end
