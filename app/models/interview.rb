class Interview < ApplicationRecord
    validates :title, presence: true
    enum :status, [:document_submit, :first_interview, :second_interview, :third_interview, :get_hired, :end_interview]
end
