class ApplicationPresenter
  def initialize(view)
    @view = view
  end

  def flash_messages
    @view.flash.each do |key, value|
      @view.concat(render_flash_message(key, value))
    end
  end

  def render_flash_message(level, message)
    @view.content_tag(:div, class: "alert #{flash_class(level)} alert-dismissible fade show") do
      @view.concat(@view.content_tag(:strong, message))
      @view.concat(@view.button_tag("", class: "btn-close", "data-bs-dismiss" => "alert"))
    end
  end

  def flash_class(level)
    case level
    when "notice"  then "alert-warning"
    when "success" then "alert-success"
    when "error"   then "alert-danger"
    when "alert"   then "alert-warning"
    end
  end
end