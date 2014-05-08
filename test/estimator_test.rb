require 'minitest/autorun'
require 'estimator'
require 'yaml'
require 'time'

class EstimatorTest < MiniTest::Unit::TestCase

    def setup
        yaml_file = "#{Dir.pwd}/test/fixtures/sample_db.yml"
        @yaml = YAML.load_file( yaml_file )
        @estimator = Estimator::Estimate.new( yaml_file )
    end

    def test_load_yaml
        yaml_file = "#{Dir.pwd}/test/fixtures/sample_db.yml"
        yaml = YAML.load_file( yaml_file )
        @estimator.load( yaml_file )

        yaml[:values].each do |key, value|
            assert_equal value, @estimator.values[key]
        end
        assert_equal yaml[:last_estimate], @estimator.last_estimate
    end

    def test_add_value
        value = Random.rand
        @estimator.add_value( value )
        assert @estimator.values.has_key?( value )
    end

    def test_estimate
        @estimator.add_value( 100, Time.parse('2014-05-07') )
        @estimator.add_value(  50, Time.parse('2014-05-08') )
        assert_equal Time.parse('2014-05-09'), @estimator.estimate
    end

end
