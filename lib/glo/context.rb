class Glo::Context 
  
  attr_reader :values 

  def initialize(params={})
    @values = params_as_strings(params)
    @success = true
  end

  def self.build(params={})
    if params.is_a? Glo::Context
      params
    elsif params.is_a? Hash
      new(params)
    else
      raise ArgumentError, "Glo::Op must be initialized with an instance of either Hash or Glo::Context and not #{params.class.to_s}."
    end
  end

  attr_writer :success
  def success
    @success
  end

  def success?
    success 
  end

  def success!
    self.success = true
  end

  def fail?
    !success?
  end

  def fail!
    @success = false
  end

  def method_missing(method_name, *arguments, &block)    
    if missing_method_is_setter? method_name
      values[method_name.to_s.gsub("=", "")] = arguments.first
    elsif missing_method_is_reader? method_name
      values[method_name.to_s]
    else
      super
    end
  end

  def missing_method_is_setter?(method_name)
    method_name.to_s[-1] == "="
  end

  def missing_method_is_reader?(method_name)
    values.key? method_name.to_s
  end 

  def respond_to_missing?(method_name, include_private = false)
    key = method_name.to_s.gsub(/=$/, "")
    if values.key? key
      true
    else
      super
    end
  end

  def params_as_strings(hash)
    hash.inject({}) do |new_hash, (k,v)| 
      new_hash[k.to_s] = v
      new_hash
    end
  end
end
