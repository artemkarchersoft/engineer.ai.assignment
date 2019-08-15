class QuestionsController < ApplicationController
  def index
    @questions = Question.order(updated_at: :desc).all

    @new_answers = NewAnswerFinder.new(questions: @questions, user: current_user).call
  end

  def show
    @question = Question.find_by(id: params[:id])

    current_user
      .user_questions
      .where(question: @question)
      .update(seen_answer_id: seen_answer_id)
  end

  def create
    @question = current_user
                  .questions
                  .create(question_params)

    current_user
      .user_questions
      .create(question: @question)

    redirect_to question_path(@question)
  rescue => error
    flash.now[:error] = error.message
    render :new
  end

  def update
    @question = current_user
                  .questions
                  .find_by(id: params[:id])

    @question.update(question_params)

    redirect_to question_path(@question)
  rescue => error
    flash.now[:error] = error.message
    render :edit
  end

  def new; end

  def destroy
    @question = current_user
                  .questions
                  .find_by(id: params[:id])

    @question.destroy
    redirect_to questions_path
  end

  def follow
    @question = Question.find_by(id: params[:id])

    current_user
      .user_questions
      .where(question: @question)
      .first_or_create

    redirect_to question_path(@question)
  end

  def unfollow
    @question = Question.find_by(id: params[:id])

    current_user
      .user_questions
      .where(question: @question)
      .delete_all

    redirect_to question_path(@question)
  end

  private

  def question_params
    params
      .require(:question)
      .permit(:title, :description)
  end

  def seen_answer_id
    @question.answers.select(:id).order(id: :desc).limit(1).pluck(:id).first
  end
end
