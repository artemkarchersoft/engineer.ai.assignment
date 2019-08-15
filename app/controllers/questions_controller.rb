class QuestionsController < ApplicationController
  def index
    @questions = Question.order(updated_at: :desc).all
  end

  def show
    @question = Question.find_by(id: params[:id])
  end

  def create
    @question = current_user
                  .questions
                  .create(question_params)
    redirect_to question_path(@question)
  rescue => error
    flash.now[:error] = error.message
    render :new
  end

  def update
    @question = Question.find_by(id: params[:id])
    @question.update(question_params)
    redirect_to question_path(@question)
  rescue => error
    flash.now[:error] = error.message
    render :edit
  end

  def new; end

  private

  def question_params
    params
      .require(:question)
      .permit(:title, :description)
  end
end
