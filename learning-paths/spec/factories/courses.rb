FactoryBot.define do
  factory :course do
    name { "Programming 101" }
    description { "MyString" }
    author { author }
    learning_path { learning_path }
    order { 1 }
  end
end
