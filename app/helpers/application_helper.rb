module ApplicationHelper

  # TODO: Consider creating a new specific helper or presenter for this method
  def flash_class(level)
      case level
          when "notice"  then "alert-warning"
          when "success" then "alert-success"
          when "error"   then "alert-danger"
          when "alert"   then "alert-warning"
      end
  end
end
