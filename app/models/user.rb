class User < ActiveRecord::Base
  has_many :appointments
  has_many :aspects, :order => "weight DESC"
  has_many :buffer_items
  has_many :goals
  has_many :ideas
  has_many :muses

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # The most important task always belongs to the most important aspect
  # We delegate the hard to work to the aspect itself to figure out the priority of
  # the tasks it contains (its entire subtree of tasks)
  def tasks(options={})
    limit = 
      if options.has_key?(:limit)
        n = options[:limit]
        options.delete(:limit)
        n
      else
        5
      end

    ret = []
    self.aspects.each do |aspect|
      next unless aspect.is_root?
      ret << aspect.tasks(options)
      ret.flatten!
      break if ret.size >= limit
    end

    return ret[0..(limit-1)]
  end
end
