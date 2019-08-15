class AnswersController < ApplicationController
  def create
    question = Question.find_by!(id: answer_params[:question_id])

    current_user
      .answers
      .create(answer_params)

    question.update(updated_at: Time.now)

    redirect_to question_path(question)
  end

  def vote_up
    answer = Answer.find_by!(id: params[:id])
    answer.votes.create(user: current_user, value: true)
    redirect_to question_path(answer.question_id)
  end

  def vote_down
    answer = Answer.find_by!(id: params[:id])
    answer.votes.create(user: current_user, value: false)
    redirect_to question_path(answer.question_id)
  end

  private

  def answer_params
    params
      .require(:answer)
      .permit(:question_id, :text)
  end
end
