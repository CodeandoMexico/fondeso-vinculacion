require 'csv'

funds = Array.new

CSV.foreach('programas.csv',:headers => true) do |csv_obj|
    funds.push csv_obj.to_hash # push the row hash into an array
end
