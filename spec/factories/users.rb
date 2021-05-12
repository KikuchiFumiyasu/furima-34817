FactoryBot.define do

  factory :user do
    nickname                 {"nick"}
    email                    {"sample@test.com"}
    password                 {"a12345"}
    password_confirmation    {password}
    first_name               {"一郎"}
    last_name                {"山田"}
    first_name_how_to_read   {"イチロウ"}
    last_name_how_to_read    {"ヤマダ"}
    birth_day                {"2021-4-20"}
  end
end
