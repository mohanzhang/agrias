module ApplicationHelper
  def rip_element(model, attribute, formtype="input")
    text = "Click to edit"
    
    unless model.send(attribute).blank?
      text = model.send(attribute)
      text = simple_format(text) if formtype == "textarea"
    end

    %{<span class="rest_in_place"
        data-url="#{polymorphic_path(model)}" data-object="#{model.class.to_s.underscore}"
        data-attribute="#{attribute}" data-formtype="#{formtype}">#{text}</span>}
  end

  def delete_link(model)
    link_to "delete", polymorphic_path(model), :remote => true, "data-method" => "delete", "data-confirm" => "Are you sure?", "data-output-mode" => "hide"
  end
end
