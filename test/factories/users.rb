FactoryGirl.define do
  factory :dom, class: User do |u|
    u.name 'Dom'
  end

  factory :joe, class: User do |u|
    u.name 'Joe'
   end
end
