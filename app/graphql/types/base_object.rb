module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    private

    def user
      context[:current_user]
    end
  end
end
