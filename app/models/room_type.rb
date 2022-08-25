class RoomType < ApplicationRecord
  NESTED_ATTRS = %i(id number _destroy).freeze
  ROOMTYPE_ATTRS = %i(name cost image capacity size services description rooms)
                   .push(rooms_attrs: NESTED_ATTRS)

  has_many :rooms, dependent: :destroy
  accepts_nested_attributes_for :rooms,
                                allow_destroy: true

  validates :name, :image, presence: true
  validates :size, :cost, :capacity, presence: true,
                                     numericality: {only_integer: true}
  validates_associated :rooms

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
