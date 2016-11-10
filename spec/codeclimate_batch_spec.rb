require "spec_helper"
require "codeclimate-test-reporter"

describe CodeclimateBatch do
  def with_env(env)
    env.each { |k,v| ENV[k] = v }
    yield
  ensure
    env.each { |k,_v| ENV[k] = nil }
  end

  it "has a VERSION" do
    CodeclimateBatch::VERSION.should =~ /^[\.\da-z]+$/
  end

  describe ".unify" do
    it "merges reports 1 report" do
      report = CodeclimateBatch.unify(["spec/files/report_a.json"])

      report.should == JSON.parse('{"Unit Tests":{"coverage":{"/sample.rb":[1,1,1],"/another_file.rb":[1,1,1]}}}')
    end

    it "merges multiple reports" do
      report = CodeclimateBatch.unify(["spec/files/report_a.json", "spec/files/report_b.json"])

      report.should == JSON.parse('{"Unit Tests":{"coverage":{"/sample.rb":[1,1,1],"/another_file.rb":[1,1,1]}}, "Integration Tests":{"coverage":{"/sample.rb":[null,0,1],"/another_file.rb":[0,1,1]}}}')
    end
  end
end
