include CanCan::Ability
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable#, :registerable
  belongs_to :organization
  has_many :user_causes
  has_many :causes, through: :user_causes
  has_many :journal_entries
  has_many :user_settings
  has_many :settings, through: :user_settings
  has_many :notifications
  belongs_to :organization_profile
  belongs_to :user_type
  after_create :define_settings

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability

  def admin?
  	#self.user_type.id == 1
    self.profile.name == 'sudo'
  end

  def setting?(setting_name)
    # Retorno el id del setings del usuario
    UserSetting.find_by_setting_id_and_user_id(Setting.find_by(name: setting_name.to_s).id, self.id).enabled 
  end

  def define_settings
    self.settings = Setting.all
    self.save
  end

  def permissions
    self.organization_profile.profile.permissions
  end

  def profile
    self.organization_profile.profile
  end

  def self.causes
    causes = Hash.new
  end

  def role(role)
    self.user_type.name == role.to_s
  end

  def notifications?
    notifications.undismissed.count > 0
  end
=begin
  def notifications
    if self.can? :read, Payment
      todays_payments.count + late_payments.count
    else
      0
    end
  end
=end
  def set_notification
    n = Notification.create(subject: 'Notificación', description: "description", dismissable: true, notification_type: NotificationType.find_by_name('notification'))
    n.update link: "#{Rails.application.routes.url_helpers.user_root_path}?n=#{n.id}"
    self.notifications << n
  end

  def self.notify
=begin
    users = User.all
    users.each do |u|
      if u.can? :read, Payment
        u.late_payments.each do |lp|
          n = Notification.create(subject: 'Pago atrasado en', description: "#{lp.cause.matter}", notification_type: NotificationType.find_by_name('late_payment'))
          n.update link: "#{Rails.application.routes.url_helpers.cause_path(lp.cause)}?n=#{n.id}#payments"
          u.notifications << n
        end
        u.todays_payments.each do |tp|
          n = Notification.create(subject: 'Cobrar causa', description: "#{tp.cause.matter}", notification_type: NotificationType.find_by_name('todays_payment'))
          n.update link: "#{Rails.application.routes.url_helpers.cause_path(tp.cause)}?n=#{n.id}#payments"
          u.notifications << n
        end
      end
      #if u.notifications?
        #UserMailer.test(u).deliver
      #end
    end
=end
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

  def soon_payments
    Payment.joins(cause: {users: :organization}).where('organizations.id = ? AND payments.date > ?', self.organization.id, Date.today).order :date
    #self.causes.map(&:payments)[0].where(date: Date.today, payed: false)
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
