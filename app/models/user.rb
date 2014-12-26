class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable#, :registerable
  belongs_to :organization
  has_many :user_causes
  has_many :causes, through: :user_causes
  has_many :journal_entries
  belongs_to :user_type

  def admin?
  	#self.user_type.id == 1
    self.role :admin
  end

  def self.causes
    causes = Hash.new
    
  end

  def role(role)
    self.user_type.name == role.to_s
  end

  def notifications?
    notifications > 0
  end

  def notifications
    todays_payments.count + late_payments.count
  end

  def self.notify
    users = User.all
    users.each do |u|
      if u.notifications?
        UserMailer.test(u).deliver
      end
    end
  end

  def clients
    clients = Hash.new
    self.causes.each do |c|
      clients[c.client.id] ||= c.client
    end
    clients
  end

  def journal_entries
    JournalEntry.joins(user_cause: {user: :organization}).where(organizations: {id: self.organization.id}).order(created_at: :desc)
  end

  def todays_payments
    Payment.joins(cause: {users: :organization}).where(organizations: {id: self.organization.id}, payments:{date: Date.today, payed: false})
    #self.causes.map(&:payments)[0].where(date: Date.today, payed: false)
  end

  def open_causes
    self.causes.reject{|c| c.state.id==6}
  end

  def late_payments
    Payment.joins(cause: {users: :organization}).where('organizations.id = ? AND payments.date < ? AND payments.payed = ?', self.organization.id, Date.today, false) #organizations: {id: self.organization.id}, payments:{date: Date.today, payed: false})
    #Payment.joins(cause: :user_causes).where('user_causes.user_id = ? AND payments.date < ? AND payments.payed = ?', self.id, Date.today, false)
    #self.organization.open_causes.count > 0 ? self.organization.open_causes.map(&:payments)[0].where('date < ? AND payed = ?', Date.today, false) : []
  end
end
