class HostelBookingsController < ApplicationController

  def index
    @bookings = HostelBooking.order('created_at ASC')
    @booking = HostelBooking.new
  end
  
  def create
    booking = HostelBooking.new(params[:hostel_booking])
    if booking.save
      redirect_to hostel_bookings_path, :notice => "Booking added"
    else
      redirect_to hostel_bookings_path, :notice => "Failed to add booking"
    end
  end

  def edit
    @booking = HostelBooking.find(params[:id]) 
  end
  
  def update
    @booking = HostelBooking.find(params[:id])

    if @booking.update_attributes(params[:hostel_booking])
      redirect_to hostel_bookings_path, :notice => "Booking updated"
    else
      render :edit, :notice => "Failed to update booking"
    end
  end

  def destroy
    booking = HostelBooking.find(params[:id])
    if booking.delete
      redirect_to hostel_bookings_path, :notice => "Booking removed"
    else
      redirect_to hostel_bookings_path, :notice => "Failed to remove booking"
    end
  end
      
  def toggle_payment
    booking = HostelBooking.find(params[:id])
    booking.update_attributes(:payment => booking.payment? ? false : true)
    redirect_to hostel_bookings_path
  end 

end
