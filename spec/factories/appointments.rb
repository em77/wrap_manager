FactoryBot.define do
  factory :appointment do
    start { Time.zone.now + 30.minutes }
  end
end
