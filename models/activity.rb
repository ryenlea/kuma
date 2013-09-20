# encoding: UTF-8
require 'digest'

ACTIVITY_STATUS = ["未开始" , "进行中",  "已结束"]
class Activity < ActiveRecord::Base
  has_many :products
  belongs_to :user

  validates :name, :started_at, :ended_at,:user_id , presence: true
  validates :name, length: {maximum: 50}
  validate :dates_must_be_valid
    
  before_create :generate_token
  
  def self.select_activity(params)
    find(params[:activity_id])
  end

  def status_desc
  	ACTIVITY_STATUS[status]
  end
  
  def status
  	if(started_at > Time.now)
      0
    elsif(ended_at > Time.now && started_at < Time.now)
      1
    elsif(ended_at < Time.now)
      2
    end
  end
  
  private
  def dates_must_be_valid
    errors.add(:started_at, "请填写正确的时间区间") if ended_at <= started_at or ended_at < Time.now
  end
  
  def generate_token 
    self.token = Digest::MD5.hexdigest("#{Random.rand(9999999)}-#{Time.now}")
  end
end