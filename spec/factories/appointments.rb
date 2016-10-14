FactoryGirl.define do
  factory :appointment do
    id 1
    start Time.zone.now + 30.minutes
  end
end
