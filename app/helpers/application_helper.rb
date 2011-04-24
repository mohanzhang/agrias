module ApplicationHelper
  def rip_element(model, attribute)
    %{<span class="rest_in_place"
        data-url="#{polymorphic_path(model)}" data-object="#{model.class.to_s.underscore}"
        data-attribute="#{attribute}">#{model.send(attribute)}</span>}
  end

  def delete_link(model)
    link_to "delete", polymorphic_path(model), :remote => true, "data-method" => "delete", "data-confirm" => "Are you sure?", "data-output-mode" => "hide"
  end
end
