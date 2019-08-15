class HomepageController < ApplicationController
  def show
    @questions = Question
                   .joins(:user_questions)
                   .where(user_questions: { user_id: current_user.id })
                   .order(updated_at: :desc)

    @new_answers = NewAnswerFinder.new(questions: @questions, user: current_user).call
  end
end
