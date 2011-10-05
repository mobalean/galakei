class Galakei::Filter::Views < Galakei::Filter::Base
  def filter
    logger.debug("appending galakei views")
    prepend_view_path(::Rails.root.join('app','views.galakei'))
  end
end
