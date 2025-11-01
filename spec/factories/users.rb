FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password" }

    trait :supervisor do
      role { "supervisor" }
    end
  end

  factory :supervisor, class: User do
    email { "admin@example.com" }
    password { "password" }
    role { "supervisor" }
  end
end
