# app/models/concerns/filterable.rb
module Filterable
  extend ActiveSupport::Concern
  OPERATORS = { from: ">=", to: "<=" }
  ALLOWED_FIXED_COLUMNS = %w[created_at updated_at]
  class_methods do
    def self.allowed_filter_columns
      ALLOWED_FIXED_COLUMNS | (column_names - ALLOWED_FIXED_COLUMNS)
    end

    def filtrate(filters = {})
      scope = all

      filters.each do |key, value|
        next if value.blank?
        if respond_to?(key)
          scope = scope.public_send(key, value)

        elsif key.to_s.match?(/_(from|to)\z/)
          base_field = key.to_s.gsub(/_(from|to)\z/, "").underscore

         if allowed_filter_columns.include?(base_field)
            table = self.arel_table
            arel_column = table[base_field]

            condition = if key.to_s.ends_with?("_from")
                          arel_column.gteq(value)
            else
                          arel_column.lteq(value)
            end

            scope = scope.where(condition)
         else
          Rails.logger.debug "Unknown base_field: #{base_field} for filter #{key}"
         end

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
