module TerminalHelper
  include AspectsHelper
  include TasksHelper

  def extend_link(model, attribute)
    link_to model.send(attribute), polymorphic_path(model), :remote => true, "data-output-mode" => "extend"
  end
end
