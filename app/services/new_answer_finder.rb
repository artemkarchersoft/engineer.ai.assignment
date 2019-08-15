class NewAnswerFinder
  attr_reader :questions, :user

  def initialize(questions:, user:)
    @questions = questions
    @user = user
  end

  def call
    query
      .map { |user_question| [user_question.question_id, user_question.result] }
      .to_h
  end

  private

  def query
    UserQuestion
      .select(:question_id, 'count(answers.id) as result')
      .joins(sql_join)
      .where(user_questions: { question_id: questions.map(&:id), user_id: user.id })
  end

  def sql_join
    <<-SQL
      inner join answers 
        on user_questions.question_id = answers.question_id 
          and (user_questions.seen_answer_id IS NULL or user_questions.seen_answer_id < answers.id)
    SQL
  end
end
