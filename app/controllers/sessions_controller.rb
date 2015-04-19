# encoding: UTF-8
class SessionsController < ApplicationController

   CONN = ActiveRecord::Base.connection  #for sql_load

def new
  if current_user
    redirect_to days_path, :notice => t(:welcome_back)
  end 
end

def create
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect_to root_path, :notice => t(:logged_in)
  else
    flash.now.alert = t(:invalid_user)
    render "new"
  end
end


def destroy
  session[:user_id] = nil
  redirect_to log_in_path, :notice => t(:logged_out)
end


def load  #sql loading stuff
  if current_user && current_user.admin

CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Прыгалка', 'Прыгалка', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Разминка', 'Разминка', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Челнок перед зеркалом', 'Челнок перед зеркалом', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Джеб', 'Джеб', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Джеб с шагом', 'Джеб с шагом ', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Джеб в челноке', 'Джеб в челноке', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Кросс', 'Кросс', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Кросс с шагом ', 'Кросс с шагом ', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Кросс в челноке', 'Кросс в челноке', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Левый боковой', 'Левый боковой', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Левый боковой с шагом ', 'Левый боковой с шагом ', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Левый боковой в челноке', 'Левый боковой в челноке', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Правый боковой', 'Правый боковой', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Правый боковой с шагом ', 'Правый боковой с шагом ', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Правый боковой в челноке', 'Правый боковой в челноке', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Джеб в корпус', 'Джеб в корпус', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Джеб в корпус с шагом ', 'Джеб в корпус с шагом ', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Джеб в корпус в челноке', 'Джеб в корпус в челноке', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Кросс в корпус', 'Кросс в корпус', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Кросс в корпус с шагом ', 'Кросс в корпус с шагом ', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Кросс в корпус в челноке', 'Кросс в корпус в челноке', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Апперкот в корпус', 'Апперкот в корпус', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Апперкот в голову', 'Апперкот в голову', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - Двойка (дальняя дистанция)', 'Комбинации - Двойка (дальняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - Почтальон (л, л, п) (дальняя дистанция)', 'Комбинации - Почтальон (л, л, п) (дальняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - джеб, уклон, один в корпус, два в голову (дальняя дистанция)', 'Комбинации - джеб, уклон, один в корпус, два в голову (дальняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - двойной джеб, уклон, в корпус, два в голову (дальняя дистанция)', 'Комбинации - двойной джеб, уклон, в корпус, два в голову (дальняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - джеб, кросс, хук ведущей рукой (в голову или в корпус) (средняя дистанция)', 'Комбинации - джеб, кросс, хук ведущей рукой (в голову или в корпус) (средняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - джеб в туловище, кросс в голову (средняя дистанция)', 'Комбинации - джеб в туловище, кросс в голову (средняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - джеб, кросс, апперкот (ведущей рукой), кросс (средняя дистанция)', 'Комбинации - джеб, кросс, апперкот (ведущей рукой), кросс (средняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - джеб, хук задней рукой в голову (средняя дистанция)', 'Комбинации - джеб, хук задней рукой в голову (средняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - джеб, апперкот задней, апперкот ведущей (средняя дистанция)', 'Комбинации - джеб, апперкот задней, апперкот ведущей (средняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - кросс в корпус, джеб ведущей (ближняя дистанция)', 'Комбинации - кросс в корпус, джеб ведущей (ближняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - хук ведущей в корпус, хук ведущей в голову / апперкот (ближняя дистанция)', 'Комбинации - хук ведущей в корпус, хук ведущей в голову / апперкот (ближняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Комбинации - хук ведущей в голову, хук ведущей в корпус (ближняя дистанция)', 'Комбинации - хук ведущей в голову, хук ведущей в корпус (ближняя дистанция)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Сайдстепы', 'Сайдстепы', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Сайдстепы - с ударом', 'Сайдстепы - с ударом', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Сайдстепы - с тремя ударами (последний в корпус)', 'Сайдстепы - с тремя ударами (последний в корпус)', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Сайдстепы - с ударом + три удара на отходе', 'Сайдстепы - с ударом + три удара на отходе', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Защита - уклоны', 'Защита - уклоны', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Защита - нырки', 'Защита - нырки', 2)")
CONN.execute("INSERT INTO dictitems (name, name_ru, kind) VALUES ('Бой с тенью', 'Бой с тенью', 2)")


#    CONN.execute("delete from exercises where day_id in (select id from days where erased = true)")
#    CONN.execute("delete from trexercises where training_id in (select id from trainings where archived = true)")
#    CONN.execute("delete from trainings where archived = true")
    redirect_to root_path, :notice => t(:data_added)
  end
end


def about
  if I18n.locale == :ru
    redirect_to '/aboutru'
  end
end  

def aboutru
  if I18n.locale == :en
    redirect_to '/about'
  end
end  

def faq
end  



def form531
  if params[:delt_max] == "" || params[:delt_reps]  == "" || params[:dead_max]  == "" || params[:dead_reps] == "" || params[:bench_max]  == "" || params[:bench_reps]  == "" || params[:sq_max] == "" || params[:sq_reps]  == "" 
    flash.now.alert = t(:need_more_info)
    render "days/bform531"
  end
end  

end
