class DocumentPresenter
  include SpecialistDocumentsHelper

  delegate :title, :details, to: :document
  delegate :summary,
    :body,
    :published_at,
    :bulk_published,
    to: :"document.details"

  def initialize(finder, document)
    @finder = finder
    @document = document
  end

  def respond_to?(method)
   if has_facet?(method.to_s)
     true
   else
     super
   end
 end

  def method_missing(method, *args)
    if has_facet?(method.to_s)
      document.details.send(method)
    else
      super
    end
  end

  def format_name
    finder.format_name
  end

  def finder_path
    finder.base_path
  end

  def date_metadata
    default_date_metadata
      .merge(extra_date_metadata)
  end

  def metadata
    expanded_filterable_metadata + expanded_extra_metadata
  end

  def headers
    document.details.headers || []
  end

  def organisations
    document.tags.select{ |t|
      t.type = "organisation"
    }
  end

  def extra_date_metadata
    finder.date_facets.each_with_object({}) { |facet, hash| hash[facet.name] = self.send(facet.key) }
  end

  def change_history
    document.details.change_history || []
  end

  def beta?
    finder.beta
  end

  def beta_message
    finder.beta_message
  end

  def footer_date_metadata
    return {} if bulk_published
    if first_edition?
      { published: nice_date_format(published_at) }
    else
      { updated: nice_date_format(published_at) }
    end
  end

private

  attr_reader :document, :finder

  def metadata_response_builder(label, values)
    OpenStruct.new(
      label: label,
      values: Array(values).map { |value|
        OpenStruct.new(label: value, linkable?: false)
      }
    )
  end

  def filterable_metadata_response_builder(key, data)
    label = data.fetch(:label)

    OpenStruct.new(
      label: label,
      values: data.fetch(:values).map { |value|
        OpenStruct.new(
          label: value.fetch(:label),
          linkable?: true,
          href: "#{finder_path}?#{key}%5B%5D=#{value.fetch(:slug)}"
        )
      }
    )
  end

  def expanded_extra_metadata
    extra_metadata
      .reject { |_, value| value.blank? }
      .map { |label, values| metadata_response_builder(label, values) }
  end

  def convert_filterable_metadata(expanded_filterable_metadata)
    expanded_filterable_metadata.map { |key, data| filterable_metadata_response_builder(key, data) }
  end

  def expanded_filterable_metadata
    present_metadata = filterable_metadata.reject { |_, value| value.blank? }
    convert_filterable_metadata(finder.user_friendly_values(present_metadata))
  end

  def default_date_metadata
    return {} if bulk_published
    caption = first_edition? ? "Published" : "Updated"

    {
      caption => published_at,
    }
  end

  def first_edition?
    change_history.size <= 1
  end

  def filterable_metadata
    finder.text_facets.select(&:filterable)
          .each_with_object({}) { |facet, hash| hash[facet.key] = self.send(facet.key) }
  end

  def extra_metadata
    finder.text_facets.reject(&:filterable)
          .each_with_object({}) { |facet, hash| hash[facet.name] = self.send(facet.key) }
  end

  def has_facet?(facet)
    finder.facets.map(&:key).include?(facet.to_s)
  end
end
