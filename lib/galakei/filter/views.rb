=begin
Have a PC site that you want to add galakei templates for? Put your views in app/views.galakei and they'll be used in preference to your normal app/views
=end
class Galakei::Filter::Views < Galakei::Filter::Base
  # :stopdoc:
  def filter
    logger.debug("appending galakei views")
    prepend_view_path(::Rails.root.join('app','views.galakei'))
  end
end
