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
  def update_patient(name , age, diseases, email)
    @name = name 
    @age = age
    @disease = diseases
    @email = email
  end

end
