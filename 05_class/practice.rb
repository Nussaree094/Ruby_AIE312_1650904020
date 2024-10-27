# Define the User class with attributes: name, email, and password
class User
    attr_accessor :name, :email, :password
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []
    end
  
    # Method to enter a room
    def enter_room(room)
      room.add_user(self)
      @rooms << room unless @rooms.include?(room)
      puts "#{@name} has entered the room: #{room.name}"
    end
  
    # Method to send a message to a room
    def send_message(room, content)
      message = Message.new(self, room, content)
      room.broadcast(message)
    end
  
    # Method to acknowledge a message in a room
    def acknowledge_message(room, message)
      puts "#{@name} acknowledges the message: '#{message.content}' in room: #{room.name}"
    end
  end
  
  # Define the Room class with attributes: name, description, and users
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    # Method to add a user to the room
    def add_user(user)
      @users << user unless @users.include?(user)
    end
  
    # Method to broadcast a message to all users in the room
    def broadcast(message)
      puts "Broadcasting message in #{name}: '#{message.content}'"
      @users.each do |user|
        user.acknowledge_message(self, message)
      end
    end
  end
  
  # Define the Message class with attributes: user, room, and content
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
  # Example usage
  # Creating users
  user1 = User.new("Alice", "alice@example.com", "password123")
  user2 = User.new("Bob", "bob@example.com", "password456")
  
  # Creating a room
  chat_room = Room.new("General", "This is a general chat room.")
  
  # Users entering the room
  user1.enter_room(chat_room)
  user2.enter_room(chat_room)
  
  # User sending a message
  user1.send_message(chat_room, "Hello, everyone!")
  