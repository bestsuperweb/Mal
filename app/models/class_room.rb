class ClassRoom < ActiveRecord::Base
	belongs_to :lesson
	belongs_to :availability, inverse_of: :class_rooms

	belongs_to :sender, foreign_key: :teacher_id, class_name: "User"
	belongs_to :recipient, foreign_key: :student_id, class_name: "User"

	has_many :messages, dependent: :destroy

	scope :requests, -> { where(approve: false).order('created_at DESC') }
	scope :active, -> { joins(:availability).where('availabilities.start_time >= ?', Time.now - 30.minutes) }
	scope :class_chats, -> { where(approve: true).order('updated_at DESC') }
	scope :teacher_activity, -> (teacher) { where(teacher_id: teacher.id, approve: true) }
	scope :student_activity, -> (student) { where(student_id: student.id, approve: true) }
	scope :for_student, -> (student) { where(student_id: student.id) }
	scope :completed, -> { joins(:availability).where('availabilities.end_time < ?', Time.now) }
	scope :with_credit, -> { where(with_credit: true) }

	scope :between, -> (teacher_id, student_id) do
		where(
			"(class_rooms.teacher_id = ? AND class_rooms.student_id = ?) OR
			(class_rooms.teacher_id = ? AND class_rooms.student_id = ?)",
			teacher_id, student_id, student_id, teacher_id
		)
	end

	def teacher_received_credit?
		!with_credit
	end

	def student(student_id)
		student = User.find_by_id(student_id)
		return student.full_name
	end
end
