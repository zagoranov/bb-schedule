module ApplicationHelper

def day_distance(dt)
  n = (Time.now.to_date - dt.to_date).to_i
  if dt.wday == 2 && I18n.locale == :ru
     	zz = "o"
  else
     	zz = ""
  end

  case n
  when 0
        rt = t(:today)
  when 1
     	rt = t(:yesterday)
  when 2..6
        rt = t(:at) + zz + " " + week_day(dt.wday)
  else
        rt = n.to_s + " " + t(:days_ago)
  end
  return rt
end


def week_day(dd)
  case dd
    when 0
     tr = t(:sunday)
    when 1
     tr = t(:monday)    	
    when 2 
     tr = t(:tuesday)    	 
    when 3
     tr = t(:wednesday)    	
    when 4
     tr = t(:thursday)    	
    when 5
     tr = t(:friday)    	
    else
     tr = t(:saturday)
   end
  return tr
  end 

end



