FactoryBot.define do
  factory :image do
    association :imageable, factory: :product

    after(:build) do |image|
      image.file.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
