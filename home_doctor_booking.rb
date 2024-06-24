#receptionist is admin 
require_relative 'Paitent'
require_relative 'Slot_menu'

#home
slot_arr = Slot_menu.slot_arr
bool = true 
puts "*** welcome to the Dashboard ***"
while bool 
  puts "\nPress 1 to view slots, add paitent \nPress 2 to view patient\nPress 3 to exit"
  
  action = gets.to_i
  case action 
  when 1 
    Slot_menu.slot_menu(slot_arr)
  when 2
    Paitent.view_paitent_list
  when 3 
    bool = false
  else 
    puts "Invalid input try again!"
  end
end 
