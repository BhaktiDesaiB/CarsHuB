create or replace procedure sp_vehicle_onboarding(
  --pi_vehicle_id VEHICLES.vehicle_id%type , 
  pi_vehicle_type VEHICLES.vehicle_type%type, 
  pi_vehicle_manufacturer VEHICLES.vehicle_manufacturer%type , 
  pi_vehicle_model VEHICLES.vehicle_model%type , 
  pi_vehicle_no VEHICLES.vehicle_no%type , 
  pi_chasis_no VEHICLES.chasis_no%type, 
  pi_engine_no VEHICLES.engine_no%type , 
  pi_vehicle_location VEHICLES.vehicle_location%type, 
  pi_vehicle_owner VEHICLES.vehicle_owner%type, 
  pi_base_cost VEHICLES.base_cost%type, 
  pi_purchase_date VEHICLES.purchase_date%type, 
  --pi_vehicle_status VEHICLES.vehicle_status%type, 
  pi_store_id VEHICLES.store_id%type 
) as 
v_vehicle_count number;
e_vehicle_exists exception;
begin
    select count(*) into v_vehicle_count from vehicles where chasis_no=pi_chasis_no;
    if v_vehicle_count > 0 then
        raise e_vehicle_exists;
    else
        insert into VEHICLES(vehicle_id,vehicle_type, 
 vehicle_manufacturer, vehicle_model, vehicle_no, chasis_no, 
engine_no, vehicle_location, vehicle_owner, base_cost,purchase_date, store_id ) 
values 
            (s_vehicle_id.NEXTVAL, pi_vehicle_type, pi_vehicle_manufacturer, pi_vehicle_model, pi_vehicle_no, pi_chasis_no, pi_engine_no, 
            pi_vehicle_location, pi_vehicle_owner, pi_base_cost, pi_purchase_date, pi_store_id);
        commit;
        dbms_output.put_line('vehicle added');        
    end if;
exception 
    when e_vehicle_exists then
       dbms_output.put_line('vehicle already exists!');

end sp_vehicle_onboarding;