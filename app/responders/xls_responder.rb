module XlsResponder
  def to_xls
    hash = make_hash
    result = ''
    case hash[:data].class.to_s
    when 'Array'
      hash[:data].each do |row|
        if result.empty?
          result << '<Row>'
          row.each do |key, value|
            result << "<Cell><Data ss:Type=\"String\">#{key}</Data></Cell>"
          end
          result << '</Row>'
        end
        result << '<Row>'
        row.each do |key, value|
          result << "'<Cell><Data ss:Type=\"#{xls_cell_type(value)}\">#{value}</Data></Cell>"
        end
        result << '</Row>'
      end
    when 'Hash'
      hash[:data].each do |key, value|
        result << "<Row><Cell><Data ss:Type=\"String\">#{key}</Data></Cell><Cell><Data ss:Type=\"#{xls_cell_type(value)}\">#{value}</Data></Cell></Row>"
      end
    when 'NilClass'
        result = "<Row><Cell><Data ss:Type=\"String\">#{hash[:success].inspect}</Data></Cell></Row>"
    else
        result = "<Row><Cell><Data ss:Type=\"#{xls_cell_type(hash[:data])}\">#{hash[:data].inspect}</Data></Cell></Row>"
    end

    result = '<?xml version="1.0"?>' +
    '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+
    ' xmlns:o="urn:schemas-microsoft-com:office:office"' +
    ' xmlns:x="urn:schemas-microsoft-com:office:excel"' +
    ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"' +
    ' xmlns:html="http://www.w3.org/TR/REC-html40">' +
    "<Worksheet ss:Name=\"Page#{hash[:page]}\"><Table>#{result}</Table></Worksheet>" +
    '</Workbook>'

    render :text => result
  end

  def xls_cell_type value
    [Bignum, Fixnum, Float].include?(value.class) ? 'Number' : 'String'
  end
end
