class Interview < ApplicationRecord
    validates :title, presence: true, uniqueness: { scope: :status }
    enum :status, [:document_submit, :first_interview, :second_interview, :third_interview, :get_hired, :end_interview]
end
