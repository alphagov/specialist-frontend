module SpecialistDocumentsHelper
  
  def nice_date_format(date)
    unless date.blank?
      string = "<time title='#{date}'>"
      string += Date.parse(date).strftime('%-d %B %Y')
      string += '</time>'
      string.html_safe
    end
  end
  
end