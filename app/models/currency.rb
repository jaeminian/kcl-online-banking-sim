## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class Currency < ApplicationRecord
    validates :shortname, length: { minimum: 3 , maximum:3}, presence: true, uniqueness: {case_sensitive: false}
    validates :bigname, length: { minimum: 3 , maximum:30}, presence: true, uniqueness: {case_sensitive: false}
end
