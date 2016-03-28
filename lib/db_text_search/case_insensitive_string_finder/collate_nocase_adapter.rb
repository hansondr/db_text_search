require 'db_text_search/case_insensitive_string_finder/adapter'
module DbTextSearch
  class CaseInsensitiveStringFinder
    class CollateNocaseAdapter < Adapter
      # (see Adapter#initialize)
      def initialize(scope, column)
        @scope  = scope
        @column = column
      end

      # (see Adapter#find)
      def find(values)
        conn = @scope.connection
        @scope.where <<-SQL.strip
          #{conn.quote_table_name(@scope.table_name)}.#{conn.quote_column_name(@column)} COLLATE NOCASE
          IN (#{values.map { |v| conn.quote(v.to_s) }.join(', ')})
        SQL
      end

      # (see Adapter.add_index)
      def self.add_index(connection, table_name, column_name, options = {})
        # TODO: Switch to the native Rails solution once it's landed, as the current one requires SQL dump format.
        # https://github.com/rails/rails/pull/18499
        index_name = options[:name] || options[:name] || "#{column_name}_nocase"
        fail "Unsuported options: #{options.keys - [:name]}" if options.size > 1
        connection.execute <<-SQL.strip
          CREATE INDEX #{index_name} ON #{connection.quote_table_name(table_name)}
            (#{connection.quote_column_name(column_name)} COLLATE NOCASE);
        SQL
      end
    end
  end
end
