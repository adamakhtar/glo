class Glo::Context < Hash
  include Hashie::Extensions::MergeInitializer
  include Hashie::Extensions::IndifferentAccess
  include Hashie::Extensions::MethodAccess
end
