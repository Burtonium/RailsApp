class User
  attr_accessor :name, :email

  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
  end
    
    def shuffle_name
        self.name.split.('').shuffle!.join
    end
  def formatted_email
    "#{@name} <#{@email}>"
  end
end