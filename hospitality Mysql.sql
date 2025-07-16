Use my_database;

-- Total Bookings --

Select 
	concat(round((count(booking_id)/1000),2),"K") as Total_Bookings 
    from fact_bookings;


-- Total Revenue --

Select	
	Concat("$", Round(sum(Revenue_Realized)/1000000),"M") As Total_Revenue
    From Fact_bookings;



-- Total Successful Booking & Total Capacity --
select 
	sum(successful_bookings) as Total_successful_bookings, 
    sum(capacity) as Total_capacity  
    from fact_aggregated_bookings;


-- Occupancy % --
select 
		round(sum(successful_bookings)/sum(capacity) * 100,2) as occupancy_percentage 
        from fact_aggregated_bookings;
        
-- Cancellation Rate 

select
 booking_status,count(booking_status) from 
 `class wise revenue & cancellation rate`
 group by booking_status;  
                                                               
-- Cancelled --
select 
	booking_status,count(booking_status) from `class wise revenue & cancellation rate`
	group by booking_status having booking_status= "Cancelled" ;
    
Delimiter //

create function Cancellation_Rate (Cancelled float) 
returns float
deterministic
begin
declare Total_Booking float;
declare CR float;

set Total_Booking = 134529;
set CR = (Cancelled/Total_Booking)*100;
return CR;
end //

-- Classwise Revenue --

select 
	room_class, 
	count(room_class) from `class wise revenue & cancellation rate` 
    group by room_class;
    
















