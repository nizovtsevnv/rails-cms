require 'csv'

module CsvResponder
  def to_csv
    hash = make_hash
    options[:csv] ||= {}
    
    result = case hash[:data].class.to_s
    when 'Array'
      CSV.generate options[:csv] do |csv|
        headers_printed = false
        hash[:data].each do |row|
          csv << row.keys if csv.lineno == 0
          csv << row.values
        end
      end
    when 'Hash'
      CSV.generate options[:csv] do |csv|
        hash[:data].each do |key, value|
          csv << [key, value]
        end
      end
    when 'NilClass'
        hash[:success].inspect
    else
        hash[:data].inspect
    end
    render :text => result
  end
end
