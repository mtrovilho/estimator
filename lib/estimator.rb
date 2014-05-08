require 'estimator/version'
require 'yaml'

module Estimator
    class Estimate
        LAST_ESTIMATE_EMPTY_STRING = 'last estimate is empty'

        attr_reader :values
        attr_reader :last_estimate
        attr_reader :file_path

        # TODO: handle file better
        def initialize( file_path )
            @file_path = file_path
            @values = {}
            @last_estimate = LAST_ESTIMATE_EMPTY_STRING
        end

        def load( file_path = @file_path )
            # TODO: change to exception?
            return nil unless File.exists?( file_path )
            # TODO: check for exception
            yaml_file      = YAML.load_file( file_path )
            @values        = yaml_file.fetch( :values, {} )
            @last_estimate = yaml_file.fetch( :last_estimate, LAST_ESTIMATE_EMPTY_STRING )
        end

        def save!
            File.open( @file_path, 'w' ) do |f|
                f.write( {
                    values: @values,
                    last_estimate: @last_estimate
                }.to_yaml )
            end
        end

        def add_value( value, time = nil )
            time = Time.now if time.nil?
            @values[value] = time
        end

        # TODO: Moving Averages
        # http://en.wikipedia.org/wiki/Moving_average
        def estimate
            return 'add more values before estimating' unless @values.count > 1
            # y = ax+b
            b = @values.keys.sort.last
            y = @values.keys.sort.first
            x = @values[y] - @values[b]
            a = (y-b)/x
            @last_estimate = @values[b] + (-b/a)
        end

    end
end
