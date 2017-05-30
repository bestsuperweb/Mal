class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lastseenable

  has_many :lessons, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :author_reviews, foreign_key: "author_id", class_name: "Review"
  has_one :teacher_stuff, dependent: :destroy
  has_many :class_rooms, foreign_key: :teacher_id
  has_many :student_rooms, foreign_key: :student_id, class_name: "ClassRoom"

  has_many :user_instruments
  has_many :user_genres
  has_many :user_levels
  has_many :instruments, through: :user_instruments
  has_many :genres, through: :user_genres
  has_many :levels, through: :user_levels
  has_many :availabilities, dependent: :destroy

  has_many :credits
  
  has_many :external_links, dependent: :destroy
  accepts_nested_attributes_for :external_links, allow_destroy: true

  validates :first_name, :last_name, :address, presence: true

  default_scope {where(active: true)}
  scope :students, -> { where(user_type: "Student") }
  scope :teachers, -> { where(user_type: "Teacher") }
  scope :inactive, -> { unscoped.where(active: false) }
  scope :verified, -> { where(verified: true) }
  scope :online, -> { where("last_seen > ?", 15.minutes.ago) }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "70x70>" }, default_url: "http://vm-mrmrs.s3.amazonaws.com/default_avatar.png"
  validates_attachment  :avatar,
                        content_type: { content_type: /\Aimage\/.*\Z/ },
                        size: { less_than: 1.megabyte }

  ransacker :full_name, formatter: proc { |v| v.mb_chars.downcase.to_s } do |parent|
    Arel::Nodes::NamedFunction.new('lower', [
      Arel::Nodes::NamedFunction.new('concat_ws', [
        Arel::Nodes.build_quoted(' '), parent.table[:first_name], parent.table[:last_name]
      ])
    ])
  end

  def profile_picture
    return avatar.url if avatar.present?
    "http://vm-mrmrs.s3.amazonaws.com/default_avatar.png"
  end

  def self.search(city)
    where("city LIKE ?", "#{city}")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def student?
    user_type == "Student" ? true : false
  end

  def teacher?
    user_type == "Teacher" ? true : false
  end

  def display_name
    full_name.presence || email
  end

  def full_address
    "#{self.address}, #{self.city}, #{self.region}, #{self.country}"
  end

  def location
    return "#{self.city}, #{self.region}, #{self.country}"
  end

  def available_credits_count
    credits.purchased_not_used.count - student_rooms.with_credit.count
  end
end
