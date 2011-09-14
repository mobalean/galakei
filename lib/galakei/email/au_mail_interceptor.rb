
# au-kddi handsets render html mail properly only when 
# all mime parts are in a flat multipart/alternate structure
class Galakei::Email::AuMailInterceptor
  def self.delivering_email(message)

    if message.to.first =~ /^.+@ezweb\.ne\.jp$/
      if message.content_type =~ /^multipart\/related/
        params = message.content_type_parameters || {}
        message.content_type = ["multipart", "alternative", params]
        message.parts.each do |part|
          if part.content_type =~ /^multipart\/alternative/
            part.parts.each{ |p| message.add_part(p) }
            message.parts.delete(part)
          end
        end
      end
    end

  end
end

