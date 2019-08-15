module FlashesHelper
  def toastr_flashes
    flash_messages = []
    flash.each do |type, message|
      if message.present?
        type = case type.to_sym
               when :notice
                 'success'
               when :success
                 'success'
               when :alert
                 'error'
               when :error
                 'error'
               when :warning
                 'warning'
               when :info
                 'info'
               end
        text = "<script>$(function() { toastr.#{type}('#{j message}'); });</script>"
        flash_messages << text.html_safe
      end
    end
    flash_messages.join("\n").html_safe
  end
end
