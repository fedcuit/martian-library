# frozen_string_literal: true

class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    result = execute_query(data)

    payload = {
      result: result.subscription? ? { data: nil } : result.to_h,
      more: result.subscription?
    }

    if result.context[:subscription_id]
      @subscription_ids << context[:subscription_id]
    end

    transmit(payload)
  end

  def unsubscribed
    @subscription_ids.each do |sid|
      MartianLibrarySchema.subscriptions.delete_subscription(sid)
    end
  end

  private

  def execute_query(data)
    MartianLibrarySchema.execute(
      query: data[:query],
      variables: data[:variables],
      operation_name: data[:operationName],
      context: context
    )
  end

  def context
    {
      current_user_id: current_user&.id,
      current_user: current_user,
      channel: self
    }
  end
end
