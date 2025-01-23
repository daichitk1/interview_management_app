class Interview < ApplicationRecord
    validates :title, presence: true
    enum status: { get_hired: 1, third_interview: 2, second_interview: 3, first_interview: 4, document_submit: 5 }
end
