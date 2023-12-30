# Used by Rails to render fields with errors. By default, it will wrap them in a div.field_with_errors tag. 
# This config show errors next to fields
# Invalid fields are marked with a .invalid class
# Information about the error is shown in a p.error element next to the invalid field.

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at('input,select,textarea')

  html = if field
           field['class'] = "#{field['class']} invalid"
           html = <<-HTML
              #{fragment&.to_s}
              <p class="error">#{instance_tag&.error_message&.first}</p>
           HTML
           html
         else
           html_tag
         end

  html.html_safe
end