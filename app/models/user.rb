class User < ApplicationRecord
  # This constant contains attributes, which shows in views.
  DISPLAYABLE_ATTRIBUTES = [ :name, :surname, :patronymic, :email, :created_at ]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :projects
  has_many  :tasks
  has_many  :workspace_memberships
  has_many  :workspaces, through: :workspace_memberships

  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :surname

  mount_uploader :photo, UserPhotoUploader

  def full_name
    [ name, surname ].join(" ")
  end
end
