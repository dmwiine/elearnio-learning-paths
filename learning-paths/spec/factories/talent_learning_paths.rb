FactoryBot.define do
  factory :talent_learning_path do
    talent { talent }
    learning_path { learning_path }
    completed { false }
  end
end
