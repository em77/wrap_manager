FactoryGirl.define do
  factory :user do
    id 1
    email "test@example.com"
    password "password"

    trait :supervisor do
      id 2
      role "supervisor"
    end
  end

  factory :supervisor, class: User do
    id 2
    email "admin@example.com"
    password "password"
    role "supervisor"
  end
end
