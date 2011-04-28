# Allow an AR model to process args via the args attribute
module ArgDriven
  def self.included(base)
    base.extend ClassMethods
  end

  class UnrecognizedArgsError < StandardError
    def initialize(args)
      @args = args
    end

    def message
      "The arguments: '#{@args}' were not recognized by any pattern"
    end
  end

  class MissingArgsError < StandardError
    def initialize(params)
      @params = params
    end

    def message
      "No args were passed. Params: #{@params}"
    end
  end

  module ClassMethods
    def on(arg_map)
      class_eval <<-EOV
        include ArgDriven::InstanceMethods

        attr_accessor :arg_errors

        validates :arg_errors, :empty => true

        def self.process!(params)
          raise ArgDriven::MissingArgsError.new(params) unless params.has_key?(:args)

          ret = nil
          if false
            nil # skip
          #{
            ret = ""
            arg_map.each do |expr,method|
              ret += "elsif (matchdata = params[:args].match(/#{expr}/))\n"
              ret += "ret = #{method}(matchdata, params)\n"
            end
            ret
          }
          else
            raise ArgDriven::UnrecognizedArgsError.new(params[:args])
          end

          return ret
        end

        def initialize(*args)
          super(*args)
          self.arg_errors = []
        end
      EOV
    end
  end

  module InstanceMethods
  end
end
