class RoomType < ApplicationRecord
  has_many :rooms, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
  scope :by_id_capacity, ->(id, capacity){where("id = #{id} AND capacity < #{capacity}")}
  scope :search_room_type, ->(id){where id: id if id.present?}
  has_many :reviews, dependent: :destroy

  scope :search_name, ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
  scope :search_status, ->(status){where(status: status.to_s) if status.present?}
  scope :search, lambda {|params|
    search_name(params[:name])
  }
end
