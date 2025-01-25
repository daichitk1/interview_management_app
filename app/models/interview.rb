class Interview < ApplicationRecord
    validates :title, presence: true
    enum :status, [:document_submit, :first_interview, :second_interview, :third_interview, :get_hired, :end_interview]
    with_options uniqueness: true do
        validates :title
        validates :status
    end
end
