module XmlResponder
  def to_xml
    render :text => make_hash.to_xml
  end
end
