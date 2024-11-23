module ApplicationHelper
  include Pagy::Frontend

  def pagy_bootstrap_nav(pagy)
    super if pagy.pages > 1
  end
end
