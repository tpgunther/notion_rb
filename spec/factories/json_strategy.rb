class JsonStrategy
  def initialize
    @strategy = FactoryBot.strategy_by_name(:create).new
  end

  delegate :association, to: :@strategy

  def result(evaluation)
    @strategy.result(evaluation).marshal_dump.with_indifferent_access
  end
end

FactoryBot.register_strategy(:json, JsonStrategy)
