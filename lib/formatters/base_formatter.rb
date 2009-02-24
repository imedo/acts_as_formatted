class BaseFormatter
  def initialize(model)
    @model = model
  end
  
  def format_text(text)
    raise NotImplementedError
  end
end
