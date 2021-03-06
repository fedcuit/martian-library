# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :items, [Types::ItemType], null: false, description: 'Returns a list of items in martian library'

    def items
      Item.preload(:user)
    end

    field :me, Types::UserType, null: true

    def me
      user
    end
  end
end
