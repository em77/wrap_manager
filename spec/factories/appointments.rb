FactoryGirl.define do
  factory :appointment do
    id 1
    start Time.now
    ending Time.now + 30.minutes
  end
end
