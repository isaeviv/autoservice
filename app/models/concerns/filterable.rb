module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = self.where(nil)
      price_start = filtering_params[:price_start].to_i if filtering_params[:price_start].present?
      price_end = filtering_params[:price_end].present? ? filtering_params[:price_end].to_i : Order.all.order(price: :desc).first.price
      filtering_params[:price] = price_start..price_end
      filtering_params.delete(:price_start)
      filtering_params.delete(:price_end)

      filtering_params.stringify_keys.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results
    end
  end
end