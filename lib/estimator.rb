require 'estimator/version'
require 'yaml'

module Estimator
  class Estimate
    attr_reader :values
    attr_reader :last_estimate
    attr_reader :file_path

    def initialize( file_name )
      file_name  = 'estimator_db.yml' if file_path.nil?
      @file_path = "#{Dir.pwd}/#{file_name}"
    end

    def load
      save! unless File.exists?( @file_path )
      yaml_file      = ( YAML.load_file( @file_path ) || {} )
      @values        = ( yaml_file[:values] || {} )
      @last_estimate = ( yaml_file[:last_estimate] || 'last estimate is empty' )
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
      @values[value.to_i] = time
    end

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
