require 'spec_helper'

describe ArgDriven do
  class TestModel < Goal
    include ArgDriven

    attr_accessor :output, :random

    on({
      /test (.+)/ => :process_test,
      /asdf (.+) (\d)/ => :process_asdf,
      /params (.+) (\d)/ => :process_params,
    })

    private

    def self.process_test(matchdata, params)
      tm = TestModel.new
      tm.output = matchdata[1]
      tm
    end

    def self.process_asdf(matchdata, params)
      tm = TestModel.new
      tm.output = matchdata[1] + matchdata[2]
      tm
    end

    def self.process_params(matchdata, params)
      tm = TestModel.new
      tm.output = params[:extra]
      tm
    end
  end

  it "can process the first pattern" do
    tm = TestModel.process!(:args => "test hello")
    tm.output.should == "hello"
  end
  
  it "can process the second pattern" do
    tm = TestModel.process!(:args => "asdf hello 1")
    tm.output.should == "hello1"
  end

  it "can raise the MissingArgsError" do
    lambda {TestModel.process!(:noargs => "whatever")}.should raise_error(ArgDriven::MissingArgsError)
  end

  it "can raise the UnrecognizedArgsError" do
    lambda {TestModel.process!(:args => "nomatch")}.should raise_error(ArgDriven::UnrecognizedArgsError)
  end

  it "can pass additional params" do
    tm = TestModel.process!(:args => "params hello 1", :extra => "goodbye")
    tm.output.should == "goodbye"
  end
end
