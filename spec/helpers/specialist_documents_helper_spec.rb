require 'spec_helper'

describe SpecialistDocumentsHelper do
  describe '#nice_date_format' do
    
    before :all do
      @time = Time.now.getutc.to_s
    end
    
    it 'should return a string with <time> tags' do
      html = helper.nice_date_format(@time)
      assert(html) =~ /<time.*?>.*?<\/\stime>/
    end
    
    it 'should return <time> tag that includes a datetime attribute which is the ISO8601 timestamp for the time provided' do
      time = Time.now
      html = helper.nice_date_format(time.to_s)
      datetime = /<time.*?datetime=['"](.*?)['"]>/.match(html)[1]
      datetime.should ==  time.iso8601
    end
    
    it 'should return a html_safe string' do
      assert(helper.nice_date_format(@time).html_safe?)
    end
    
    it 'should return nil if the string provded is blank or not a time' do
      assert(helper.nice_date_format(nil).nil?)      
    end
    
    it 'should return the string provided in the format: 31 Febuary 2001' do
      formatted_timestamp = '1 December 2013'
      timestamp = '2013-12-1T15:35:33+00:00'
      
      cleaned_timestamp = strip_tags(helper.nice_date_format(timestamp))
      cleaned_timestamp.should == formatted_timestamp
    end
    
  end
end