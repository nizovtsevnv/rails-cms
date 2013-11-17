class ApiResponder < ActionController::Responder
  include CsvResponder
  include JsonResponder
  include XlsResponder
  include XmlResponder

  def get_attributes item
    if item.is_a? Hash
      return item.keys
    elsif item.respond_to? 'attribute_names'
      return item.attribute_names
    end
  end
  
  def make_hash # from resource
    response = {}

    if !options[:success].nil?
      if options[:success] == :resource
        response[:success] = !!resource
      else
        response[:success] = options[:success]
      end
    end

    response[:errors] = options[:errors] if options[:errors]
    # add ActiveRecord errors
    if has_errors?
      response[:errors] ||= {}
      resource.errors.messages.each do |attribute, message|
        response[:errors][attribute] = message
      end
    end

    # no data, only success field
    if options[:success] == :resource
    # list of data objects
    elsif resource.is_a?(Array) || resource.is_a?(ActiveRecord::Relation)
      response[:page] = options[:page].nil? ? 1 : options[:page]
      response[:per] = options[:per].nil? ? resource.size : options[:per]
      response[:total] = options[:total].nil? ? resource.size : options[:total]
      response[:data] = []
      resource.each do |item|
        response[:data] << make_item(item)
      end
    # single data object
    else
      response[:data] = make_item(resource)
    end
    response
  end

  def make_item item
    @attributes ||= options[:attributes] ? options[:attributes] : get_attributes(item)
    data = {}
    if @attributes.is_a?(Array) && (item.is_a?(Hash) || item.respond_to?('attribute_names'))
      @attributes.each do |attribute|
        data[attribute] = item.send(attribute).to_s
      end
    else
      data = item
    end
    data
  end
end
