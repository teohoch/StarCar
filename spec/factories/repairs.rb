FactoryBot.define do
  factory :repair do
    workshop "MyString"
    employee nil
    reason "MyText"
    quote 1
    status 1
    return_date "2018-02-16"
  end
end
