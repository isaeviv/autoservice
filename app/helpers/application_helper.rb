module ApplicationHelper
  def delete_button(object, css_class: nil)
    button_to object, method: :delete, class: "btn btn-danger #{css_class}" do
     icon("fa-regular", "trash-can")
    end
  end
end
