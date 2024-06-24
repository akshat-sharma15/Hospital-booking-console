#receptionist is admin 
class Slot_exception < StandardError
  def initialize(str = 'wrong slot selection')
      super(str)
  end 
end

class Paitent
  @@paitent_list = Array.new
  @@paitent_count = 0
  @@waiting = 0
  def initialize(name,age,diseases,email,swift,slot = "waiting")
      @name = name
      @age = age
      @diseases = diseases
      @email = email
      @swift = swift
      @slot = slot
      @@paitent_list.push(self)
      @@paitent_count += 1
      if slot == "waiting"
          @@waiting += 1
      end
  end
  def email
      @email
  end
  def self.paitent_list
      @@paitent_list
  end
  def slotc=(str)
      @slot = str
  end
  def slot
      @slot
  end
  def name 
      @name
  end
  def age
      @age
  end
  def diseases
      @diseases
  end

  def paitent_view
      puts("\nName : #{@name}\nAge : #{@age}\nDiseases : #{@diseases}\nEmail : #{@email}\nSwift : #{@swift}\nSlot : #{@slot}\n")
  end
  def self.view_paitent_list
      if(@@paitent_count == 0)
          puts "List empty"
      end
      count = 1
      @@paitent_list.each do |var|
          print "\n #{count}" 
          print " Name : #{var.name}  Age : #{var.age} \n"
          print "#{var.email} "
          puts "  Diseases #{var.diseases}" 
          puts "Slot Stautus : #{var.slot}\n"
          count += 1
      end
  end
  def self.view_waiting
      if @@waiting == 0
          puts "Wating list empty"
      end
      count = 1
      @@paitent_list.each do |var|
          if var.slot == "waiting"
              print "\n #{count}" 
          print " Name : #{var.name}  "
          print "#{var.email} "
          count += 1
          end
      end
  end
  def self.waiting_paitent
      if @@waiting == 0
          puts "Wating list empty"
      end
      @@paitent_list.each do |var|
          if var.slot == "waiting"
              return var
          end 
      end 
      return -1
  end
  def Paitent.waiting_count
      @@waiting
  end
  def self.waiting_minus
      @@waiting -= 1
  end
end

# main
  $empty_slot = 6
  $books = 0
  slot_arr = Array.new(6, -1)   

  def valid_slot(slot_arr)
      print "Enter vaild slot from the list given below number : \n"
      
      for i in 0..5
          unless slot_arr[i] == -1
              puts "Slot no. : #{i+1}"
          end
      end
      slot = -1
      bool = true
      while bool
          begin
              # puts "Enter 0 to go back to previous menu"
              slot = gets.to_i
              # if slot == 0
              #     slot_menu(slot_arr)
              #     break
              # end
              if slot >= 1 and slot <= 6
                  if(slot_arr[slot-1] != -1)
                      return slot
                  else
                      raise Slot_exception.new("Empty Slot selection please select valid slot from list")
                  end                
              else 
                  raise Slot_exception.new("Invalid input please enter correct slot")
              end
          rescue Slot_exception => caught
              puts "#{caught.message}"
          end
      end
  end

  # add paitent to the slot method
  
  def add_paitent(slot_arr)
      wait = false
      if $empty_slot < 1 
          puts "Slots Not available press 1 to add patient to wating list"
          choice = gets.to_i
          if choice == 1
              wait = true
          else
              return
          end
      else
          print "enter slot no. : "
          check = true
          while check
              slot = gets.to_i
              if slot >= 1 and slot <= 6
                  if(slot_arr[slot-1] == -1)
                      break
                  else
                      puts "Booked slot please select another slot"
                  end                
              else 
                  puts "Invalid input please enter correct slot"
              end
          end
      end

      print "Enter name of the paitent :"
      valid = true
      regex = /\A[A-Za-z]+(([' -][A-Za-z])?[A-Za-z]*)*\z/
      while valid
          begin
              name = gets.chomp
              if(name.match?(regex))
                  valid = false
              else
                  raise Slot_exception.new("Please Enter a valid name\n")
              end
          rescue Slot_exception => caught
              puts "#{caught.message}"
              redo 
          end
      end
      print "Enter age of the paitent :"
      valid = true
      regex = /^(100|[1-9]?[0-9])$/
      while valid
          begin
              age = gets.chomp
              if(age.match?(regex))
                  if(age.to_i > 100 || age.to_i <0)
                      raise Slot_exception.new("Enter a valid age between 0 - 100\n")
                  else
                      valid = false
                  end
              else
                  raise Slot_exception.new("Age is accpted in number between 0 - 100\n")
              end
          rescue Slot_exception => caught
              puts "#{caught.message}"
              redo 
          end
      end
      print "Enter diseases of the paitent :"
      diseases = gets.chomp
      print "Enter Email of the user : "
      valid = true
      regex = /\A[a-zA-Z0-9.]+@gmail\.com\z/
      email =""
      while valid
          begin
              email = gets.chomp
              if (email.match?(regex))
                  Paitent.paitent_list.each do |var|
                      if(var.email == email)
                          raise Slot_exception.new("Email already exist please enter another one")
                      end
                  end
                  valid = false
              else
                  raise Slot_exception.new("Invaild email address please enter valid email")
              end
          rescue Slot_exception => caught
              puts "#{caught.message}"
              redo 
          end
          
      end
      print "Enter swift (Morining or Evening) : "
      swift = gets.chomp
      if wait
          Paitent.new(name,age,diseases,email,swift)
      else
      slot_arr[slot-1] = Paitent.new(name,age,diseases,email,swift,slot)
      $empty_slot -= 1
      $books += 1
      end

      puts "\nData Added Successfullly !!!!\n"

  end
      slot_arr[0] = Paitent.new("narsh",7,"na","hr@email.com","m",1)
      slot_arr[1] = Paitent.new("varsh",7,"na","hr@email.com","m",2)
      slot_arr[2] = Paitent.new("darsh",7,"na","hr@email.com","m",3)
      slot_arr[3] = Paitent.new("carsh",7,"na","hr@email.com","m",4)
      slot_arr[4] = Paitent.new("tarsh",7,"na","hr@email.com","m",5)
      slot_arr[5] = Paitent.new("vinyh",7,"na","hr@email.com","m",6)
      Paitent.new("sursh",7,"na","hr@email.com","m")
      Paitent.new("gursh",7,"na","hr@email.com","m")
      $empty_slot = 0
      $books = 6

  def view_slot_list(slot_arr)
      puts "-----------------------------------------"
      for i in 0...6
          print "Slot No. #{i+1}       |  "
          if( slot_arr[i] == -1)
              puts "Empty"
          else
              varp = slot_arr[i]
              puts "#{varp.name}"
          end
      end
      puts "-----------------------------------------"
  end
  
  # slot menu
  def slot_menu(slot_arr)
      view_slot_list(slot_arr)
      bool = true
      while bool
          puts "\npress 1 to add new paitent to empty slot \nPress 2 for delete paitent form slot\nPress 3 for view paitent detail on slot\nPress 4 to view slot list\nPress 5 to view waiting list\nPress 0 for previous menu"
          action = gets.to_i
          
          case action
          when 1
              add_paitent(slot_arr)
          when 2 
              if($empty_slot == 6)
                  puts "All slots are empty !!"
                  redo
              end
              slot=valid_slot(slot_arr)
              slot_arr[slot-1].slotc = "Appoinment Done"
              if Paitent.waiting_count != 0
              var = Paitent.waiting_paitent
                  if var.class != -1 or var.class.to_s == "Paitent"
                      slot_arr[slot-1] = var
                      var.slotc = slot
                      Paitent.waiting_minus
                  end
              # puts var.paitent_view
              # puts var.class
              
              else
                  slot_arr[slot-1] = -1
                  $empty_slot += 1 
                  $books -= 1 
              end

              puts "Slot cleared thank you!!"
          when 3
              if($empty_slot == 6)
                  puts "All slots are empty !!"
                  redo
              end
              slot=valid_slot(slot_arr)
              slot_arr[slot-1].paitent_view
          when 4
              view_slot_list(slot_arr)
          when 5
              Paitent.view_waiting
          when 0
              bool = false
          else 
              puts "Invalid input try again!" 
          end
      end
  end

  #home
  bool = true 
  puts "*** welcome to the Dashboard ***"
  while bool 
      puts "\nPress 1 to view slots, add paitent \nPress 2 to view patient\nPress 3 to exit"
      
      action = gets.to_i
      case action 
      when 1 
          slot_menu(slot_arr)
      when 2
          Paitent.view_paitent_list
      when 3 
          bool = false
      else 
          puts "Invalid input try again!"
      end
  end 

      






