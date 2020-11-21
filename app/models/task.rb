class Order < ApplicationRecord

  belongs_to :assignee, foreign_key: "assignee_id", class_name: "User", optional: true

  paginates_per 10

  filterrific(
    default_filter_params: { sorted_by: "created_at_desc" },
    available_filters: [
      :urgent,
      :approved,
      :sorted_by
    ]
  )

  def options_for_sorted_by
    [
      ["Oldest", "created_at_asc"],
      ["Newest", "created_at_desc"],
    ]
  end

  def name
    services.map{ |s| s.name }.join(", ").humanize
  end

  scope :sorted_by, ->(sort_option) {
    direction = /desc$/.match?(sort_option) ? "desc" : "asc"
    case sort_option.to_s
    when /^created_at_/
      order("created_at #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }
  scope :approved, -> (val){ where("approved_at IS NOT NULL") if val === 1 }
  scope :urgent, -> (val){ where("urgent = TRUE") if val === 1 }
  scope :available, -> { where("approved_at IS NOT NULL AND assignee_id IS NULL") }
end
