require "administrate/base_dashboard"

class AuthSessionDashboard < Administrate::BaseDashboard

    ATTRIBUTE_TYPES = {
        user: Field::BelongsTo,
        id: Field::Number,
        user_agent: Field::String,
        created_at: Field::DateTime,
        expires_at: Field::DateTime,
        claimed_at: Field::DateTime,
        timeout_at: Field::DateTime
    }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    user
    user_agent
    created_at
    expires_at
    claimed_at
    timeout_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user
    user_agent
    created_at
    expires_at
    claimed_at
    timeout_at
  ].freeze


  FORM_ATTRIBUTES = %i[].freeze

  COLLECTION_FILTERS = {}.freeze

end
