class DefaultValueToSeenAnswerId < ActiveRecord::Migration[5.2]
  def change
    change_column :user_questions, :seen_answer_id, :bigint, default: 0
  end
end
