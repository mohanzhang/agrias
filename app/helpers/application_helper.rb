module ApplicationHelper
  def rip_element(model, attribute)
    %{<span class="rest_in_place"
        data-url="#{polymorphic_path(model)}" data-object="#{model.class.to_s.underscore}"
        data-attribute="#{attribute}">#{model.send(attribute)}</span>}
  end
end
