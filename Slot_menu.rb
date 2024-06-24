require_relative 'Paitent'

class Slot_exception < StandardError
  def initialize(str = 'wrong slot selection')
      super(str)
  end 
end

class Slot_menu
  $empty_slot = 6
  $books = 0
  @@slot_arr = Array.new(6, -1)   
  def self.slot_arr
    @@slot_arr
  end

  def self.valid_slot(slot_arr)
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

  def self.vaild_name
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
    return name
  end

  def self.vald_age
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
    return age
  end
   
  def self.valid_email
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
    return email
  end

  # add paitent to the slot method

  def self.add_paitent(slot_arr)
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

    name =  vaild_name
    age = vald_age
    email = valid_email
    print "Enter diseases of the paitent :"
    diseases = gets.chomp

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

    #test data
    slot_arr[0] = Paitent.new("narsh",7,"na","hr1@gmail.com","m",1)
    slot_arr[1] = Paitent.new("varsh",7,"na","hr2@gmail.com","m",2)
    slot_arr[2] = Paitent.new("darsh",7,"na","hr3@gmail.com","m",3)
    slot_arr[3] = Paitent.new("carsh",7,"na","hr4@gmail.com","m",4)
    slot_arr[4] = Paitent.new("tarsh",7,"na","hr5@gmail.com","m",5)
    slot_arr[5] = Paitent.new("vinyh",7,"na","hr6@gmail.com","m",6)
    Paitent.new("sursh",7,"na","hr7@gmail.com","m")
    Paitent.new("gursh",7,"na","hr8@gmail.com","m")
    $empty_slot = 0
    $books = 6
    # test data over
      
  def self.view_slot_list(slot_arr)
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
  def self.slot_menu(slot_arr)
    Slot_menu.view_slot_list(slot_arr)
    bool = true
    while bool
      puts "\npress 1 to add new paitent to empty slot \nPress 2 for delete paitent form slot\nPress 3 for view paitent detail on slot\nPress 4 to view slot list\nPress 5 to update paitent details \nPress 6 to view waiting list\nPress 0 for previous menu"
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
        puts "Enter email of the user whose data you want to update"
        change_obj =""
        check = true
        while check
          email = gets.chomp
          Paitent.paitent_list.each do |var|
            if(var.email == email)
              change_obj = var
              check = false
            end
          end 
          if check
            puts "enter correct email that you entered previously"
          end 
        end
        check =  true 
        name = change_obj.name
        age = change_obj.age 
        email = change_obj.email
        disease = change_obj.diseases
        while check
          puts "Press 1 to upadate name\nPress 2 to update age\nPress 3 to update diseases\nPress 4 to upadate email\nPress 6 to confirm changes"
          input =  gets.to_i
          case input 
          when 1 
            name =  vaild_name
          when 2 
            age = vald_age
          when 3
            puts "Enter diesases to upadate"
            disease = gets.chomp
          when 4 
            email = valid_email
          when 6 
            check = false
          else
            puts "Invaild input !!"
          end
        end
        change_obj.update_patient(name,age,disease,email)
        puts "Changes Made successfully"
      when 6
        Paitent.view_waiting
      when 0
        bool = false
      else 
        puts "Invalid input try again!" 
      end
    end
  end

end
