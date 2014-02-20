module SpecialistDocumentsHelper
  
  def nice_date_format(time)
    unless time.blank?
      string = "<time datetime='#{Time.parse(time).iso8601}'>"
      string += Time.parse(time).strftime('%-d %B %Y')
      string += '</time>'
      string.html_safe
    end
  end
  
end