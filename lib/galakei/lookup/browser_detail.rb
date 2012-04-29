module Galakei::Lookup::BrowserDetail
  def details_for_lookup
    super.merge(:browsers => browser_detail_for_request)
  end

  private

  def browser_detail_for_request
    (request.galakei? ? [ :galakei ] : [ :full ])
  end
end
