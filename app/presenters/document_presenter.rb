class DocumentPresenter
  include SpecialistDocumentsHelper
  include Breadcrumbs

  delegate :title, :description, :details, :public_updated_at, to: :document
  delegate :body, to: :"document.details"

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

  def finder_name
    finder.title
  end

  def format_name
    finder.format_name
  end

  def finder_path
    finder.base_path
  end

  def date_metadata
    default_date_metadata
      .merge(expanded_extra_date_metadata)
  end

  def metadata
    expanded_filterable_metadata + expanded_extra_metadata
  end

  def headers
    document.details.headers || []
  end

  def organisations
    if finder.links && finder.links.organisations
      finder.links.organisations
    else
      []
    end
  end

  def expanded_extra_date_metadata
    expand_metadata(extra_date_metadata, change_values: false)
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
      { published: nice_date_format(public_updated_at) }
    else
      { updated: nice_date_format(public_updated_at) }
    end
  end

  def bulk_published
    document.details.metadata["bulk_published"]
  end

private

  attr_reader :document, :finder

  def metadata_response_builder(data)
    OpenStruct.new(
      label: data.fetch(:label),
      values: Array(data.fetch(:values)).map do |value|
        OpenStruct.new(
          label: value,
          linkable?: false
        )
      end
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
    expand_metadata(extra_metadata, change_values: false).map { |_, data| metadata_response_builder(data) }
  end

  def expanded_filterable_metadata
    expand_metadata(filterable_metadata).map { |key, data| filterable_metadata_response_builder(key, data) }
  end

  def expand_metadata(unexpanded_metadata, change_values: true)
    present_metadata = unexpanded_metadata.reject { |_, value| value.blank? }
    finder.user_friendly(present_metadata, change_values: change_values)
  end

  def default_date_metadata
    return {} if bulk_published
    caption = first_edition? ? "Published" : "Updated"

    {
      caption.downcase => {
        label: caption,
        values: public_updated_at,
      }
    }
  end

  def extra_date_metadata
    keys = finder.date_facets.map(&:key)
    get_metadata(keys)
  end

  def first_edition?
    change_history.size <= 1
  end

  def filterable_metadata
    keys = finder.text_facets.select(&:filterable).map(&:key)
    get_metadata(keys)
  end

  def extra_metadata
    keys = finder.text_facets.reject(&:filterable).map(&:key)
    get_metadata(keys)
  end

  def get_metadata(keys)
    metadata_hash.slice(*keys)
  end

  def metadata_hash
    @metadata_hash ||= document.details.metadata.to_h.stringify_keys
  end

  def has_facet?(facet)
    finder.facets.map(&:key).include?(facet.to_s)
  end
end
