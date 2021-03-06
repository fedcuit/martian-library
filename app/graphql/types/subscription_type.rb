# frozen_string_literal: true

module Types
  class SubscriptionType < GraphQL::Schema::Object
    field :item_added, Types::ItemType, null: false, description: 'An item was added'

    def item_added; end

    field :item_updated, Types::ItemType, null: false, description: 'Existing item was updated'

    def item_updated; end
  end
end
