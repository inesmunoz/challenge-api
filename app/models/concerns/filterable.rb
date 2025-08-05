# app/models/concerns/filterable.rb
module Filterable
  extend ActiveSupport::Concern

  class_methods do
    def filtrate(filters = {})
      scope = all

      filters.each do |key, value|
        next if value.blank?

        if respond_to?(:filterable_like_fields) && filterable_like_fields.include?(key.to_s)
          scope = scope.where("#{key} ILIKE ?", "%#{value}%")

        elsif respond_to?(key)
          scope = scope.public_send(key, value)

        elsif key.to_s.match?(/_from|_to/)
          base_field = key.to_s.gsub(/_(from|to)\z/, '')
          operator = key.to_s.ends_with?('_from') ? '>=' : '<='
          scope = scope.where("#{base_field} #{operator} ?", value)

        elsif value.is_a?(Array)
          scope = scope.where(key => value)

        else
          scope = scope.where(key => value)
        end
      end

      scope
    end
  end
end
