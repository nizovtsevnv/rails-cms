module JsonResponder
  def to_json
    render :text => make_hash.to_json
  end
end
