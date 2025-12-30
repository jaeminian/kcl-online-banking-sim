## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

class Account < ApplicationRecord
  belongs_to :user
  validates :curr_id, presence: true
  # Ensure sortcode is of the format dd-dd-dd or dddddd
  VALID_SORTCODE_REGEX = /\A((\d\d-\d\d-\d\d)|(\d{6}))\Z/
  validates :sortcode, presence: true, format: { with: VALID_SORTCODE_REGEX }
  validates :user_id, presence: true
	#Ensure account number is a sequence of numbers, where space between digits is allowed
	# Also ensure the check for the uniqueness of the field is not case sensitive
  VALID_ACCNUMBER_REGEX = /\A(\d)*\d+\Z/
  validates :accnumber, presence: true, format: { with: VALID_ACCNUMBER_REGEX }, uniqueness: {case_sensitive: false}
  validates :accname, presence: true
end
