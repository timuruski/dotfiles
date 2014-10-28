#! /usr/bin/env ruby

require 'cgi'
require 'time'
require 'uri'


# SAMPLE REQUEST
# http://rigdata.caodc.ca/CAODC/ModuleUI/DrillingRig/DrillingRigActivityDailyExport.aspx?day=Mar.%203,%202014&divisionID=1

module CAODC
  module DrillingRigActivity
    class DailyExport
      HOSTNAME = 'rigdata.caodc.ca'
      BASE_PATH = '/CAODC/ModuleUI/DrillingRig/DrillingRigActivityDailyExport.aspx'

      def initialize(date)
        @date = date
      end

      def fetch
        query = build_query(day: export_date, divisionID: 1)
        url = URI::HTTP.build(host: HOSTNAME, path: BASE_PATH, query: query)

        puts url
      end

      protected

      def build_query(params = {})
        params.map { |key, value|
          key = URI.encode(key.to_s)
          value = URI.encode(value.to_s)
          "#{key}=#{value}"
        }.join('&')
      end

      def export_date
        @date.strftime('%b.%_d, %Y')
      end
    end
  end
end


export_date = Date.parse(ARGV.first || '2013-11-20')
CAODC::DrillingRigActivity::DailyExport.new(export_date).fetch
