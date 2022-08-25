class RoomType < ApplicationRecord
  has_many :rooms, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
  scope :by_id_capacity, ->(id, capacity){where("id = #{id} AND capacity < #{capacity}")}
  scope :search_room_type, ->(id){where id: id if id.present?}

  scope :search_name, ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
  validates :name, :image, :size, :cost, :capacity, presence: true
end
