class ApplicationController < ActionController::Base
  def successful_message(model, action)
    t("successful_#{action}", model: t(model))
  end
end
