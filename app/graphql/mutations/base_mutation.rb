module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    def check_authentication!
      return if user

      raise GraphQL::ExecutionError, 'You need to authenticate to perform this action'
    end

    private

    def user
      context[:current_user]
    end
  end
end